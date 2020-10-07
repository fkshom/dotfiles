<#

PowerShellの実行ポリシーを変更して実行
Set-ExecutionPolicy RemoteSigned
 #=> yesを選択
.dotfiles\install.ps1

コマンドプロンプトで実行
powershell -NoProfile -ExecutionPolicy Unrestricted .dotfiles\install.ps1
#>

function check_and_output($path){
  if(test-path ".dotfiles\$path" -PathType leaf){
    Write-Host "mklink /H $path .dotfiles\$path"
  } elseif(test-path .dotfiles\$path -PathType Container){
    Write-Host "mklink /J $path .dotfiles\$path"
  } else {
  }
}

$files = @(
  ".emacs.d",
  ".spacemacs.d",
  ".gitconfig",
  ".globalrc",
  ".nyagos"
)

foreach($file in $files){
  check_and_output($file)
}

