// Fill out your copyright notice in the Description page of Project Settings.


#include "NimClassBase.h"

#include "FNimHotReload.h"
#include "ReflectionHelpers.h"
#include "Subsystems/AssetEditorSubsystem.h"


UNimEnum::UNimEnum(const FObjectInitializer& Initializer) : UEnum(Initializer) {
	SetEnumFlags(EEnumFlags::Flags);
}

TArray<TPair<FName, int64>> UNimEnum::GetEnums() {
	return this->Names;
}

void UNimEnum::MarkNewVersionExists() {
	SetEnumFlags(EEnumFlags::NewerVersionExists);
}

int FNimHotReload::GetNumber()
{
	return 5;
}
