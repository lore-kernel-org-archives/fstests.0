Received: from mail-yw0-f193.google.com ([209.85.161.193]:36052 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdIKLDl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Sep 2017 07:03:41 -0400
Received: by mail-yw0-f193.google.com with SMTP id r85so1890600ywg.3
        for <fstests@vger.kernel.org>; Mon, 11 Sep 2017 04:03:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505121946-4900-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1505121946-4900-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Sep 2017 14:03:39 +0300
Message-ID: <CAOQ4uxgUkcoe3-o7jLzo4mWvuezLy_BV49AtVhMsF=ofH0hgYg@mail.gmail.com>
Subject: Re: [PATCH] generic/456: add check for fallocate flags
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 11, 2017 at 12:25 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> On RHEL6.9GA, this case could not emulate a crash and passed due
> to unsupported collapse_range and zero_range instead of no bug.
>
> We added check for fallocate flags to avoid confusion.
>

I am not sure I understand the confusion.

A bug was allegedly introduced to ext4 when introducing
collapse_range and/or insert_range and this is a regression test
for this alleged regression.

In what way is it confusing that the test passes on an old kernel?
There are a lot of tests in xfstests that test for regressions that
were introduced by commit XYZ. I don't see those tests checking
that they are running on kernel > XYZ.

BTW, this test also passes on btrfs and xfs, but it does not include
_supported_fs ext4 against confusion.


> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/generic/456 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/generic/456 b/tests/generic/456
> index 8debd3f..b72acea 100755
> --- a/tests/generic/456
> +++ b/tests/generic/456
> @@ -67,11 +67,16 @@ write 0x3e5ec 0x1a14 0x21446
>  zero_range 0x20fac 0x6d9c 0x40000 keep_size
>  mapwrite 0x216ad 0x274f 0x40000
>  EOF
> -run_check $here/ltp/fsx -d --replay-ops $fsxops $SCRATCH_MNT/testfile
> +touch $tmp.dupops
> +run_check $here/ltp/fsx -d --replay-ops $fsxops --record-ops=$tmp.dupops $SCRATCH_MNT/testfile
>
>  _flakey_drop_and_remount
>  _unmount_flakey
>  _cleanup_flakey
> +
> +ops_name=$(awk '/skip/ {printf "%s ", $2}' $tmp.dupops)
> +[ -n "$ops_name" ] && _notrun "fallocate does not support $ops_name"
> +

If you must add some check, please add
_require_xfs_io_command "fcollapse"
_require_xfs_io_command "fzero"

It is not really a must for this test and its not even really testing if fs
supports those commands, but that is de-facto standard for not
running fcollapse/fzero tests.

Thanks,
Amir.
