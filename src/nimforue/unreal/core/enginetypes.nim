include ../definitions
import math/vector
import ../coreuobject/[uobject, coreuobject]

type 
  AActor* {.importcpp.}  = object of UObject
  AActorPtr* = ptr AActor
  AController* {.importcpp.} = object of AActor
  AControllerPtr* = ptr AController
  APlayerController* {.importcpp.} = object of AController
  APlayerControllerPtr* = ptr APlayerController
  APawn* {.importcpp.} = object of AActor
  APawnPtr* = ptr APawn

  AInfo* = object of AActor
  AInfoPtr* = ptr AInfo
  AGameSession* = object of AInfo
  AGameSessionPtr* = ptr AGameSession

  UActorComponent* {.importcpp, inheritable, pure .} = object of UObject
  UActorComponentPtr* = ptr UActorComponent
  USceneComponent* {.importcpp, inheritable, pure .} = object of UActorComponent
  USceneComponentPtr* = ptr USceneComponent
  UPrimitiveComponent* {.importcpp, inheritable, pure .} = object of USceneComponent
  UPrimitiveComponentPtr* = ptr UPrimitiveComponent
  UShapeComponent* {.importcpp, inheritable, pure .} = object of UPrimitiveComponent
  UShapeComponentPtr* = ptr UShapeComponent
  UChildActorComponent* {.importcpp, inheritable, pure .} = object of USceneComponent
  UChildActorComponentPtr* = ptr UChildActorComponent

  UBlueprint* {.importcpp, inheritable, pure .} = object of UObject
  UBlueprintPtr* = ptr UBlueprint

  UBlueprintFunctionLibrary* {.importcpp, inheritable, pure .} = object of UObject
  UBlueprintGeneratedClass* {.importcpp, inheritable, pure .} = object of UClass
  UBlueprintGeneratedClassPtr* = ptr UBlueprintGeneratedClass
  UAnimBlueprintGeneratedClass* {.importcpp, inheritable, pure .} = object of UBlueprintGeneratedClass
  UAnimBlueprintGeneratedClassPtr* = ptr UAnimBlueprintGeneratedClass


  UTexture* {.importcpp, inheritable, pure .} = object of UObject
  UTexturePtr* = ptr UTexture
  UTextureRenderTarget2D* {.importcpp, inheritable, pure .} = object of UTexture
  UTextureRenderTarget2DPtr* = ptr UTextureRenderTarget2D

  UAsyncActionLoadPrimaryAssetBase* {.importcpp, inheritable, pure .} = object of UObject

  ASceneCapture* {.importcpp, inheritable, pure .} = object of AActor
  ASceneCapturePtr* = ptr ASceneCapture

  UDataAsset* {.importcpp, inheritable, pure .} = object of UObject
  UDataAssetPtr* = ptr UDataAsset

  AVolume* {.importcpp, inheritable, pure .} = object of UObject
  AVolumePtr* = ptr AVolume

  UGameInstanceSubsystem* {.importcpp, inheritable, pure .} = object of UObject
  UGameInstanceSubsystemPtr* = ptr UGameInstanceSubsystem
  UWorldSubsystem* {.importcpp, inheritable, pure .} = object of UObject
  UWorldSubsystemPtr* = ptr UWorldSubsystem
  UTickableWorldSubsystem* {.importcpp, inheritable, pure .} = object of UObject
  UTickableWorldSubsystemPtr* = ptr UTickableWorldSubsystem



  UVectorField* {.importcpp, inheritable, pure .} = object of UObject
  UVectorFieldPtr* = ptr UVectorField


  FHitResult* {.importc, bycopy} = object
    bBlockingHit: bool

  UDeveloperSettings* {.importcpp .} = object of UObject
  UEdGraphNode* {.importcpp .} = object of UObject

  UStreamableRenderAsset* {.importcpp, inheritable, pure .} = object of UObject
  UStreamableRenderAssetPtr* = ptr UStreamableRenderAsset

#[
  UActorComponent", "APawn",
            "UPrimitiveComponent", "UPhysicalMaterial", "AController",
            "UStreamableRenderAsset", "UStaticMeshComponent", "UStaticMesh",
            "USkeletalMeshComponent", "UTexture2D", "FKey", "UInputComponent",
            "ALevelScriptActor", "FFastArraySerializer", "UPhysicalMaterialMask",
            "UHLODLayer"

]#
  UMeshComponent* {.importcpp, inheritable, pure .} = object of UPrimitiveComponent
  UMeshComponentPtr* = ptr UMeshComponent
  UStaticMeshComponent* {.importcpp, inheritable, pure .} = object of UMeshComponent
  UStaticMeshComponentPtr* = ptr UStaticMeshComponent
  UStaticMesh* {.importcpp, inheritable, pure .} = object of UStreamableRenderAsset
  UStaticMeshPtr* = ptr UStaticMesh
  USkinnedMeshComponent* {.importcpp, inheritable, pure .} = object of UMeshComponent
  USkinnedMeshComponentPtr* = ptr USkinnedMeshComponent
  USkeletalMeshComponent* {.importcpp, inheritable, pure .} = object of USkinnedMeshComponent
  USkeletalMeshComponentPtr* = ptr USkeletalMeshComponent
  USkeletalMesh* {.importcpp, inheritable, pure .} = object of UStreamableRenderAsset
  USkeletalMeshPtr* = ptr USkeletalMesh
  UTexture2D* {.importcpp, inheritable, pure .} = object of UTexture
  UTexture2DPtr* = ptr UTexture2D
  UInputComponent* {.importcpp, inheritable, pure .} = object of UActorComponent
  UInputComponentPtr* = ptr UInputComponent
  ALevelScriptActor* {.importcpp, inheritable, pure .} = object of AActor
  ALevelScriptActorPtr* = ptr ALevelScriptActor
  UPhysicalMaterial* {.importcpp, inheritable, pure .} = object of UObject
  UPhysicalMaterialPtr* = ptr UPhysicalMaterial
  UPhysicalMaterialMask* {.importcpp, inheritable, pure .} = object of UObject
  UPhysicalMaterialMaskPtr* = ptr UPhysicalMaterialMask
  UHLODLayer* {.importcpp, inheritable, pure .} = object of UObject
  UHLODLayerPtr* = ptr UHLODLayer
  USoundBase* {.importcpp, inheritable, pure .} = object of UObject
  USoundBasePtr* = ptr USoundBase
  UMaterialInterface* {.importcpp, inheritable, pure .} = object of UObject
  UMaterialInterfacePtr* = ptr UMaterialInterface
  USubsurfaceProfile* {.importcpp, inheritable, pure .} = object of UObject
  USubsurfaceProfilePtr* = ptr USubsurfaceProfile
  UParticleSystem* {.importcpp, inheritable, pure .} = object of UObject
  UParticleSystemPtr* = ptr UParticleSystem
  UBillboardComponent* {.importcpp, inheritable, pure .} = object of UPrimitiveComponent
  UBillboardComponentPtr* = ptr UBillboardComponent
  UDamageType* {.importcpp, inheritable, pure .} = object of UObject
  UDamageTypePtr* = ptr UDamageType
  UDecalComponent* {.importcpp, inheritable, pure .} = object of USceneComponent
  UDecalComponentPtr* = ptr UDecalComponent
  UWorld* {.importcpp, inheritable, pure .} = object of UObject
  UWorldPtr* = ptr UWorld
  UCanvas* {.importcpp, inheritable, pure .} = object of UObject
  UCanvasPtr* = ptr UCanvas
  UDataLayer* {.importcpp, inheritable, pure .} = object of UObject
  UDataLayerPtr* = ptr UDataLayer
  

proc makeFHitResult*(): FHitResult {.importcpp:"FHitResult()", constructor.}





# type 
#     ETeleportType* {.importcpp, size: sizeof(uint8).} = enum
#         None,
#         TeleportPhysics,
#         ResetPhysic

#[
type
  # FSlateBrush*  = object
  FSlateBrush* {.importcpp, header:"Styling/SlateBrush.h".} = object
    # bIsDynamicallyLoaded*: uint8
    # imageType*: ESlateBrushImageType
    # mirroring*: ESlateBrushMirrorType
    # tiling*: ESlateBrushTileType
    # drawAs*: ESlateBrushDrawType
    # uVRegion*: FBox2f
    # resourceName*: FName
    # resourceObject*: TObjectPtr[UObject]
    # outlineSettings*: FSlateBrushOutlineSettings
    # tintColor*: FSlateColor
    # margin*: FMargin
    ImageSize*: FVector2D
]#