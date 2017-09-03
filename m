Received: from mail-yw0-f195.google.com ([209.85.161.195]:33325 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdICKCM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Sep 2017 06:02:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170903084002.1900-1-chandan@linux.vnet.ibm.com>
References: <20170903084002.1900-1-chandan@linux.vnet.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Sep 2017 13:02:11 +0300
Message-ID: <CAOQ4uxgy7CJeFZkbdqes8+3J0he9mX=BEkG5gFO_gcEWcj8UJQ@mail.gmail.com>
Subject: Re: [PATCH V4] overlay: Test constant d_ino feature
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, overlayfs <linux-unionfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 3, 2017 at 11:40 AM, Chandan Rajendra
<chandan@linux.vnet.ibm.com> wrote:
> This commit adds a test to verify constant d_ino feature. The following
> scenarios are checked,
> - Parent's (i.e. "..") d_ino must always be calculated because a pure
>   dir can be residing inside a merged dir.
> - d_ino for "." must always be calculated because the present directory
>   can have a copy-up origin.
> - Verify d_ino of '.' and '..' before and after dir becomes
>   impure. While at it also verify if trusted.overlay.impure xattr is
>   set/reset appropriately and invalidation of readdir cache.
> - Verify copied up file's (inside a impure dir) d_ino.
> - Verify d_ino values corresponding to "." and ".." entries of a pure
>   lower dir.
> - Verify d_ino of ".." entry of a merged dir.
> - Verify pure lower residing in dir which has another lower layer
>
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
> Changelog:
> v3->v4:
> 1. Fix error handling as suggested by Amir.
> 2. Use sane variable names for "Verify pure lower residing in dir which has
>    another lower layer" test.
>
...
> +# Verify invalidation of readdir cache
> +$here/src/t_dir_type $impure_dir $test_file_st_ino
> +[[ $? != 0 ]] || echo "Directory's readdir cache has stale entries"
> +
> +$GETFATTR_PROG --absolute-names -n 'trusted.overlay.impure' \
> +              $upperdir/test_dir/impure_dir >>$seqres.full 2>&1
> +[[ $? == 0 ]] && echo "Pure directory has impure xattr"
> +

Sorry, I overlooked a few things in v3:
1. Why did  I say use && echo here I'm not sure. looking again feels
    much better to conform to all other tests
2. I wanted to write and forgot that you need _require_attrs and
include common/attr
3. This test is using double brackets [[ == comparison all around,
which apparently
    saves the need to surround left side in quotes "". This seems to
be recommended
    so I have no objection. Just pointing out to Eryu in case he has
reservations.

Amir.
