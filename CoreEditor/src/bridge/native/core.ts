import { NativeModule } from '../nativeModule';
import { LineColumnInfo } from '../../modules/selection/types';

/**
 * @shouldExport true
 * @invokePath core
 * @bridgeName NativeBridgeCore
 */
export interface NativeModuleCore extends NativeModule {
  notifyWindowDidLoad(): void;
  notifyTextDidChange(): void;
  notifySelectionDidChange({ lineColumn }: { lineColumn: LineColumnInfo }): void;
}
