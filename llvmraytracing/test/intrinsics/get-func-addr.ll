; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt --verify-each -passes='dxil-cont-lgc-rt-op-converter,lint,lower-raytracing-pipeline,lint' -S %s --lint-abort-on-error | FileCheck %s

%struct.DispatchSystemData = type { i32 }

declare i64 @_AmdGetFuncAddrMyFunc()

%struct.TraversalData = type { }

declare !pointeetys !8 i32 @_cont_GetLocalRootIndex(%struct.DispatchSystemData*)
declare !pointeetys !12 i1 @_cont_ReportHit(%struct.TraversalData* %data, float %t, i32 %hitKind)

define void @_cont_ExitRayGen(ptr nocapture readonly %data) alwaysinline nounwind !pointeetys !8 {
  ret void
}

define { i64, i32 } @main() !lgc.rt.shaderstage !10 {
; CHECK-LABEL: define void @main
; CHECK-SAME: (i64 [[RETURNADDR:%.*]], [[STRUCT_DISPATCHSYSTEMDATA:%.*]] [[TMP0:%.*]]) !lgc.rt.shaderstage [[META5:![0-9]+]] !continuation.entry [[META11:![0-9]+]] !continuation.registercount [[META5]] !continuation [[META12:![0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SYSTEM_DATA_ALLOCA:%.*]] = alloca [[STRUCT_DISPATCHSYSTEMDATA]], align 8
; CHECK-NEXT:    [[PAYLOAD_SERIALIZATION_ALLOCA:%.*]] = alloca [0 x i32], align 4
; CHECK-NEXT:    store [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP0]], ptr [[SYSTEM_DATA_ALLOCA]], align 4
; CHECK-NEXT:    call void @amd.dx.setLocalRootIndex(i32 0)
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 (...) @lgc.cps.as.continuation.reference__i64(ptr @MyFunc)
; CHECK-NEXT:    [[V0:%.*]] = insertvalue { i64, i32 } undef, i64 [[TMP1]], 0
; CHECK-NEXT:    ret void
;
entry:
  %val = call i64 @_AmdGetFuncAddrMyFunc()
  %v0 = insertvalue { i64, i32 } undef, i64 %val, 0
  ret { i64, i32 } %v0
}

define i32 @MyFunc() {
; CHECK-LABEL: define i32 @MyFunc() {
; CHECK-NEXT:    ret i32 5
;
  ret i32 5
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
!7 = !{i32 21}
!8 = !{%struct.DispatchSystemData poison}
!9 = !{i32 0, %struct.DispatchSystemData poison}
!10 = !{i32 0}
!11 = !{i32 0, %struct.TraversalData poison}
!12 = !{%struct.TraversalData poison}

