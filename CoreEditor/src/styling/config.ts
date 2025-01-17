import { EditorView, highlightActiveLine } from '@codemirror/view';
import { EditorTheme, loadTheme } from './themes';
import { Config } from '../config';
import { styleSheets } from '../common/store';
import { gutterExtensions } from './nodes/gutter';
import { invisiblesExtension } from './nodes/invisible';
import { calculateFontSize } from './nodes/heading';
import { updateStyleSheet } from './helper';

/**
 * Style sheets that can be changed dynamically.
 *
 * Generally, we can either disable them or update css rules inside them.
 */
export default interface StyleSheets {
  accentColor?: HTMLStyleElement;
  fontFamily?: HTMLStyleElement;
  fontSize?: HTMLStyleElement;
  focusMode?: HTMLStyleElement;
  lineHeight?: HTMLStyleElement;
}

export function setUp(config: Config) {
  setAccentColor(loadTheme(config.theme).accentColor);
  setFontFamily(config.fontFamily);
  setFontSize(config.fontSize);
  setFocusMode(config.focusMode);
  setLineHeight(config.lineHeight);
}

export function setTheme(theme: EditorTheme) {
  const editor = window.editor as EditorView | null;

  // Editor may have not been initialized
  if (typeof editor?.dispatch === 'function') {
    editor.dispatch({
      effects: window.dynamics.theme.reconfigure(theme.extension),
    });
  }

  setAccentColor(theme.accentColor);
}

export function setAccentColor(accentColor: string) {
  if (styleSheets.accentColor === undefined) {
    const style = document.createElement('style');
    style.textContent = '.cm-md-header {}';

    styleSheets.accentColor = style;
    document.head.appendChild(style);
  }

  updateStyleSheet(styleSheets.accentColor, style => style.color = accentColor);
}

export function setFontFamily(fontFamily: string) {
  if (styleSheets.fontFamily === undefined) {
    const style = document.createElement('style');
    style.textContent = '.cm-content * {}';

    styleSheets.fontFamily = style;
    document.head.appendChild(style);
  }

  updateStyleSheet(styleSheets.fontFamily, style => style.fontFamily = fontFamily);
}

export function setFontSize(fontSize: number) {
  if (styleSheets.fontSize === undefined) {
    const style = document.createElement('style');
    style.textContent = `
      .cm-editor {}
      .cm-md-heading1 {}
      .cm-md-heading2 {}
      .cm-md-heading3 {}
    `;

    styleSheets.fontSize = style;
    document.head.appendChild(style);
  }

  updateStyleSheet(styleSheets.fontSize, (style, rule) => {
    // E.g., .cm-md-heading1 -> 1, .cm-editor -> 0
    const headingLevel = parseInt(rule.selectorText.slice(-1)) || 0;
    style.fontSize = `${calculateFontSize(fontSize, headingLevel)}px`;
  });
}

export function setShowLineNumbers(enabled: boolean) {
  const editor = window.editor as EditorView | null;
  if (typeof editor?.dispatch === 'function') {
    editor.dispatch({
      effects: window.dynamics.gutters?.reconfigure(enabled ? gutterExtensions : []),
    });
  }
}

export function setShowActiveLineIndicator(enabled: boolean) {
  const editor = window.editor as EditorView | null;
  if (typeof editor?.dispatch === 'function') {
    editor.dispatch({
      effects: window.dynamics.activeLine?.reconfigure(enabled ? highlightActiveLine() : []),
    });
  }
}

export function setShowInvisibles(enabled: boolean) {
  const editor = window.editor as EditorView | null;
  if (typeof editor?.dispatch === 'function') {
    editor.dispatch({
      effects: window.dynamics.invisibles?.reconfigure(enabled ? invisiblesExtension : []),
    });
  }
}

export function setFocusMode(enabled: boolean) {
  if (styleSheets.focusMode === undefined) {
    const style = document.createElement('style');
    style.textContent = `
      .cm-line:not(.cm-activeLine), .cm-gutterElement:not(.cm-activeLineGutter) {
        filter: grayscale(1);
        opacity: 0.3;
      }
    `;

    style.disabled = true;
    styleSheets.focusMode = style;
    document.head.appendChild(style);
  }

  styleSheets.focusMode.disabled = !enabled;
}

export function setLineWrapping(enabled: boolean) {
  const editor = window.editor as EditorView | null;
  if (typeof editor?.dispatch === 'function') {
    editor.dispatch({
      effects: window.dynamics.lineWrapping?.reconfigure(enabled ? EditorView.lineWrapping : []),
    });
  }
}

export function setLineHeight(lineHeight: number) {
  if (styleSheets.lineHeight === undefined) {
    const style = document.createElement('style');
    style.textContent = '.cm-line {}';

    styleSheets.lineHeight = style;
    document.head.appendChild(style);
  }

  updateStyleSheet(styleSheets.lineHeight, style => style.lineHeight = `${lineHeight * 100}%`);
}
