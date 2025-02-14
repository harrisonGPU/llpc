; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt --verify-each -passes='dxil-cont-prepare-gpurt-library,lint,dxil-cont-lgc-rt-op-converter,lint,inline,lint,lower-raytracing-pipeline,lint,sroa,lint,lower-await,lint,coro-early,dxil-coro-split,coro-cleanup,lint,cleanup-continuations,lint,dxil-cont-post-process,lint,continuations-lint,remove-types-metadata' -S %s --lint-abort-on-error | FileCheck -check-prefix=MINCOUNT %s
; RUN: opt --verify-each -passes='dxil-cont-prepare-gpurt-library,lint,dxil-cont-lgc-rt-op-converter,lint,inline,lint,lower-raytracing-pipeline,lint,continuations-lint,remove-types-metadata' -S %s --lint-abort-on-error | FileCheck -check-prefix=LOWERRAYTRACINGPIPELINE-MINCOUNT %s

%struct.DispatchSystemData = type { i32 }

@debug_global = external global i32

declare i32 @_AmdContPayloadRegistersI32Count()
%struct.TraversalData = type { i32 }

declare !pointeetys !9 <3 x i32> @_cont_DispatchRaysIndex3(%struct.DispatchSystemData*)
declare !pointeetys !9 i32 @_cont_GetLocalRootIndex(%struct.DispatchSystemData*)
declare !pointeetys !12 i1 @_cont_ReportHit(%struct.TraversalData* %data, float %t, i32 %hitKind)

define void @_cont_ExitRayGen(ptr nocapture readonly %data) alwaysinline nounwind !pointeetys !{%struct.DispatchSystemData poison} {
  ret void
}

define void @main() {
; MINCOUNT-LABEL: define void @main(
; MINCOUNT-SAME: i32 [[CSPINIT:%.*]], i32 [[RETURNADDR:%.*]], [[STRUCT_DISPATCHSYSTEMDATA:%.*]] [[TMP0:%.*]]) !continuation [[META10:![0-9]+]] !lgc.rt.shaderstage [[META5:![0-9]+]] !continuation.entry [[META11:![0-9]+]] {
; MINCOUNT-NEXT:  entry:
; MINCOUNT-NEXT:    [[CSP:%.*]] = alloca i32, align 4
; MINCOUNT-NEXT:    store i32 [[CSPINIT]], ptr [[CSP]], align 4
; MINCOUNT-NEXT:    [[DOTFCA_0_EXTRACT:%.*]] = extractvalue [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP0]], 0
; MINCOUNT-NEXT:    call void @amd.dx.setLocalRootIndex(i32 0)
; MINCOUNT-NEXT:    store i32 11, ptr @debug_global, align 4
; MINCOUNT-NEXT:    ret void
;
; LOWERRAYTRACINGPIPELINE-MINCOUNT-LABEL: define void @main(
; LOWERRAYTRACINGPIPELINE-MINCOUNT-SAME: i32 [[RETURNADDR:%.*]], [[STRUCT_DISPATCHSYSTEMDATA:%.*]] [[TMP0:%.*]]) !continuation [[META10:![0-9]+]] !lgc.rt.shaderstage [[META5:![0-9]+]] !continuation.entry [[META11:![0-9]+]] !continuation.registercount [[META5]] {
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:  entry:
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    [[SYSTEM_DATA_ALLOCA:%.*]] = alloca [[STRUCT_DISPATCHSYSTEMDATA]], align 8
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    [[PAYLOAD_SERIALIZATION_ALLOCA:%.*]] = alloca [0 x i32], align 4
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    store [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP0]], ptr [[SYSTEM_DATA_ALLOCA]], align 4
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    call void @amd.dx.setLocalRootIndex(i32 0)
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    store i32 11, ptr @debug_global, align 4
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    call void @lgc.cps.complete()
; LOWERRAYTRACINGPIPELINE-MINCOUNT-NEXT:    unreachable
;
entry:
  %val = call i32 @_AmdContPayloadRegistersI32Count()
  store i32 %val, i32* @debug_global, align 4
  ret void
}

!dx.entryPoints = !{!0, !3}
!continuation.maxPayloadRegisterCount = !{!7}
!continuation.maxUsedPayloadRegisterCount = !{!8}

!0 = !{null, !"", null, !1, !6}
!1 = !{!2, null, null, null}
!2 = !{!3}
!3 = !{void ()* @main, !"main", null, null, !4}
!4 = !{i32 8, i32 7, i32 6, i32 16, i32 7, i32 8, i32 5, !5}
!5 = !{i32 0}
!6 = !{i32 0, i64 65536}
!7 = !{i32 15}
!8 = !{i32 11}
!9 = !{%struct.DispatchSystemData poison}
!10 = !{i32 0, %struct.DispatchSystemData poison}
!11 = !{i32 0, %struct.TraversalData poison}
!12 = !{%struct.TraversalData poison}
