import { EditorView } from '@codemirror/view';
import { extensions } from './extensions';
import { editedState } from './common/store';

import * as styling from './styling/config';
import * as lineEndings from './modules/lineEndings';

/**
 * Reset the editor to the initial state.
 *
 * @param doc Initial content
 */
export function resetEditor(doc: string) {
  // eslint-disable-next-line
  if (window.editor && window.editor.destroy) {
    window.editor.destroy();
  }

  const editor = new EditorView({
    doc,
    parent: document.querySelector('#editor') ?? document.body,
    extensions: extensions({
      lineBreak: lineEndings.getLineBreak(doc, window.config.defaultLineBreak),
    }),
  });

  editor.focus();
  window.editor = editor;

  // Recofigure, window.config might have changed
  styling.setUp(window.config);

  // After calling editor.focus(), the selection is set to [Ln 1, Col 1]
  window.nativeModules.core.notifySelectionDidChange({
    lineColumn: { line: 1 as CodeGen_Int, column: 1 as CodeGen_Int, length: 0 as CodeGen_Int },
  });
}

/**
 * Clear the editor, set the content to empty.
 */
export function clearEditor() {
  const editor = window.editor;
  editor.dispatch({
    changes: { from: 0, to: editor.state.doc.length, insert: '' },
  });
}

export function getEditorText() {
  const state = window.editor.state;
  if (state.lineBreak === '\n') {
    return state.doc.toString();
  }

  // It looks like state.doc.toString() always uses LF instead of state.lineBreak
  const lines: string[] = [];
  for (let index = 1; index <= state.doc.lines; ++index) {
    lines.push(state.doc.line(index).text);
  }

  // Re-join with specified line break, might be CRLF for example
  return lines.join(state.lineBreak);
}

export function markEditorDirty(isDirty: boolean) {
  editedState.isDirty = isDirty;
}
