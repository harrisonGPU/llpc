; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs --version 3
; RUN: opt --verify-each -passes='dxil-cont-prepare-gpurt-library,lint' -S %s --lint-abort-on-error | FileCheck %s

target datalayout = "e-m:e-p:64:32-p20:32:32-p21:32:32-p32:32:32-i1:32-i8:8-i16:16-i32:32-i64:32-f16:16-f32:32-f64:32-v8:8-v16:16-v32:32-v48:32-v64:32-v80:32-v96:32-v112:32-v128:32-v144:32-v160:32-v176:32-v192:32-v208:32-v224:32-v240:32-v256:32-n8:16:32"

%struct.DispatchSystemData = type { i32 }
%struct.TraversalData = type { %struct.SystemData, i32, i64 }
%struct.SystemData = type { %struct.DispatchSystemData, float }

; Function Attrs: nounwind memory(none)
define i32 @_cont_GetContinuationStackAddr() #0 {
  ret i32 1
}

; Function Attrs: nounwind
define void @_cont_TraceRay(%struct.DispatchSystemData* noalias nocapture sret(%struct.DispatchSystemData) %agg.result, %struct.DispatchSystemData* nocapture readonly %data, i64 %accelStruct, i32 %rayFlags, i32 %instanceInclusioMask, i32 %rayContributionToHitGroupIndex, i32 %multiplierForGeometryContributionToShaderIndex, i32 %missShaderIndex, float %originX, float %originY, float %originZ, float %tMin, float %dirX, float %dirY, float %dirZ, float %tMax) #1 !pointeetys !2 {
  %1 = alloca %struct.TraversalData, align 4
  %2 = alloca %struct.DispatchSystemData, align 4
  %3 = getelementptr inbounds %struct.DispatchSystemData, %struct.DispatchSystemData* %data, i32 0, i32 0
  %4 = load i32, i32* %3, align 4
  %5 = bitcast %struct.TraversalData* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 12, i8* %5) #3
  %6 = getelementptr inbounds %struct.TraversalData, %struct.TraversalData* %1, i32 0, i32 0, i32 0, i32 0
  store i32 %4, i32* %6, align 4
  %addr = call i64 @_AmdGetResumePointAddr() #3
  %a = getelementptr inbounds %struct.TraversalData, %struct.TraversalData* %1, i32 0, i32 2
  store i64 %addr, i64* %a, align 4
  call void @"\01?_AmdWaitAwait@@YA?AUDispatchSystemData@@UTraversalData@@@Z"(%struct.DispatchSystemData* nonnull sret(%struct.DispatchSystemData) %2, i64 3, i64 -1, %struct.TraversalData* nonnull %1) #3
  %7 = getelementptr inbounds %struct.DispatchSystemData, %struct.DispatchSystemData* %2, i32 0, i32 0
  %8 = load i32, i32* %7, align 4
  %9 = getelementptr inbounds %struct.DispatchSystemData, %struct.DispatchSystemData* %agg.result, i32 0, i32 0
  store i32 %8, i32* %9, align 4
  call void @llvm.lifetime.end.p0i8(i64 12, i8* %5) #3
  ret void
}

declare !pointeetys !3 void @"\01?_AmdWaitAwait@@YA?AUDispatchSystemData@@UTraversalData@@@Z"(%struct.DispatchSystemData* sret(%struct.DispatchSystemData), i64, i64, %struct.TraversalData*) #2

; Function Attrs: nounwind
declare i64 @_AmdGetResumePointAddr() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare !pointeetys !5 void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare !pointeetys !5 void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

attributes #0 = { nounwind memory(none) "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="0" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="0" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="0" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }

!0 = !{%struct.DispatchSystemData poison}
!1 = !{i32 0, %struct.DispatchSystemData poison}
!2 = !{null, %struct.DispatchSystemData poison, %struct.DispatchSystemData poison}
!3 = !{null, %struct.DispatchSystemData poison, null, null, %struct.TraversalData poison}
!4 = !{i32 0, %struct.TraversalData poison}
!5 = !{i8 poison}
!6 = !{i32 0, i8 poison}
; CHECK-LABEL: define i32 @_cont_GetContinuationStackAddr(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    ret i32 1
;
;
; CHECK-LABEL: define %struct.DispatchSystemData @_cont_TraceRay(
; CHECK-SAME: ptr nocapture readonly [[DATA:%.*]], i64 [[ACCELSTRUCT:%.*]], i32 [[RAYFLAGS:%.*]], i32 [[INSTANCEINCLUSIOMASK:%.*]], i32 [[RAYCONTRIBUTIONTOHITGROUPINDEX:%.*]], i32 [[MULTIPLIERFORGEOMETRYCONTRIBUTIONTOSHADERINDEX:%.*]], i32 [[MISSSHADERINDEX:%.*]], float [[ORIGINX:%.*]], float [[ORIGINY:%.*]], float [[ORIGINZ:%.*]], float [[TMIN:%.*]], float [[DIRX:%.*]], float [[DIRY:%.*]], float [[DIRZ:%.*]], float [[TMAX:%.*]]) #[[ATTR1:[0-9]+]] !pointeetys [[META0:![0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = alloca [[STRUCT_TRAVERSALDATA:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = alloca [[STRUCT_DISPATCHSYSTEMDATA:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = alloca [[STRUCT_DISPATCHSYSTEMDATA]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_DISPATCHSYSTEMDATA]], ptr [[DATA]], i32 0, i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast ptr [[TMP1]] to ptr
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 12, ptr [[TMP6]]) #[[ATTR5:[0-9]+]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT_TRAVERSALDATA]], ptr [[TMP1]], i32 0, i32 0, i32 0, i32 0
; CHECK-NEXT:    store i32 [[TMP5]], ptr [[TMP7]], align 4
; CHECK-NEXT:    [[ADDR:%.*]] = call i64 @_AmdGetResumePointAddr() #[[ATTR5]]
; CHECK-NEXT:    [[A:%.*]] = getelementptr inbounds [[STRUCT_TRAVERSALDATA]], ptr [[TMP1]], i32 0, i32 2
; CHECK-NEXT:    store i64 [[ADDR]], ptr [[A]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = load [[STRUCT_TRAVERSALDATA]], ptr [[TMP1]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = call [[STRUCT_DISPATCHSYSTEMDATA]] @[[_AMDAWAIT:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](i64 3, [[STRUCT_TRAVERSALDATA]] [[TMP8]]) #[[ATTR5]], !waitmask [[META1:![0-9]+]]
; CHECK-NEXT:    store [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP9]], ptr [[TMP2]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT_DISPATCHSYSTEMDATA]], ptr [[TMP2]], i32 0, i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[TMP10]], align 4
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT_DISPATCHSYSTEMDATA]], ptr [[TMP3]], i32 0, i32 0
; CHECK-NEXT:    store i32 [[TMP11]], ptr [[TMP12]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 12, ptr [[TMP6]]) #[[ATTR5]]
; CHECK-NEXT:    [[TMP13:%.*]] = load [[STRUCT_DISPATCHSYSTEMDATA]], ptr [[TMP3]], align 4
; CHECK-NEXT:    ret [[STRUCT_DISPATCHSYSTEMDATA]] [[TMP13]]
;
