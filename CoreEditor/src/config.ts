import { Compartment } from '@codemirror/state';

/**
 * @shouldExport true
 * @overrideModuleName EditorLocalizable
 */
export interface Localizable {
  // CodeMirror
  controlCharacter: string;
  foldedLines: string;
  unfoldedLines: string;
  foldedCode: string;
  unfold: string;
  foldLine: string;
  unfoldLine: string;
  // Others
  previewButtonTitle: string;
}

/**
 * @shouldExport true
 * @overrideModuleName EditorConfig
 */
export interface Config {
  text: string;
  theme: string;
  fontFamily: string;
  fontSize: number;
  showLineNumbers: boolean;
  showActiveLineIndicator: boolean;
  showInvisibles: boolean;
  typewriterMode: boolean;
  focusMode: boolean;
  lineWrapping: boolean;
  lineHeight: number;
  defaultLineBreak?: string;
  tabKeyBehavior?: CodeGen_Int;
  indentUnit?: string;
  localizable?: Localizable;
}

/**
 * Dynamic configurations that can be reconfigured.
 */
export interface Dynamics {
  theme: Compartment;
  gutters?: Compartment;
  invisibles?: Compartment;
  activeLine?: Compartment;
  lineWrapping?: Compartment;
  lineEndings?: Compartment;
  indentUnit?: Compartment;
}
