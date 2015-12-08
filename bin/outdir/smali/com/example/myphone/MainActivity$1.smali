.class Lcom/example/myphone/MainActivity$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/myphone/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/myphone/MainActivity;


# direct methods
.method constructor <init>(Lcom/example/myphone/MainActivity;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/example/myphone/MainActivity$1;->this$0:Lcom/example/myphone/MainActivity;

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 41
    new-instance v0, Lcom/example/myphone/CPhone;

    invoke-direct {v0}, Lcom/example/myphone/CPhone;-><init>()V

    sput-object v0, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    .line 42
    sget-object v0, Lcom/example/myphone/MainActivity;->objPhone:Lcom/example/myphone/CPhone;

    invoke-virtual {v0}, Lcom/example/myphone/CPhone;->Start()V

    .line 43
    return-void
.end method
