; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt --verify-each -passes='dxil-cont-lgc-rt-op-converter,lint,dxil-cont-prepare-gpurt-library,lint' -S %s --lint-abort-on-error | FileCheck %s

%struct.DispatchSystemData = type { i32 }

@debug_global = external global i1

declare i1 @_AmdContinuationStackIsGlobal()

declare !pointeetys !8 i32 @_cont_GetLocalRootIndex(%struct.DispatchSystemData*)

define void @main() {
; CHECK-LABEL: define void @main(
; CHECK-SAME: ) !lgc.rt.shaderstage [[META5:![0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @lgc.rt.shader.index()
; CHECK-NEXT:    call void @amd.dx.setLocalRootIndex(i32 [[TMP0]])
; CHECK-NEXT:    store i1 true, ptr @debug_global, align 1
; CHECK-NEXT:    ret void
;
entry:
  %val = call i1 @_AmdContinuationStackIsGlobal()
  store i1 %val, ptr @debug_global
  ret void
}

!dx.entryPoints = !{!0, !3}
!continuation.stackAddrspace = !{!7}

!0 = !{null, !"", null, !1, !6}
!1 = !{!2, null, null, null}
!2 = !{!3}
!3 = !{i1 ()* @main, !"main", null, null, !4}
!4 = !{i32 8, i32 7, i32 6, i32 16, i32 7, i32 8, i32 5, !5}
!5 = !{i32 0}
!6 = !{i32 0, i64 65536}
!7 = !{i32 22}
!8 = !{%struct.DispatchSystemData poison}
