Received: from mail-yw0-f193.google.com ([209.85.161.193]:36687 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeADIJJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jan 2018 03:09:09 -0500
Received: by mail-yw0-f193.google.com with SMTP id r205so313650ywb.3
        for <fstests@vger.kernel.org>; Thu, 04 Jan 2018 00:09:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180104011801.10141-1-harshads@google.com>
References: <20171101001159.88570-1-harshads@google.com> <20180104011801.10141-1-harshads@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Jan 2018 10:09:08 +0200
Message-ID: <CAOQ4uxguExYyi4gkDmAedgQcCSXSucG3_nP4YzT0x9AbqTNJxA@mail.gmail.com>
Subject: Re: [PATCH v3] ext4/030: Ext4 online resize with bigalloc tests.
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: harshads <harshads@google.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 4, 2018 at 3:18 AM, harshads <harshads@google.com> wrote:
> Add tests to verify Ext4 online resizing feature with bigalloc feature
> enabled. We test various resizing scenarios with different cluster
> sizes.
>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> ---
>  common/rc          |  23 ++++++++
>  tests/ext4/030     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/group   |   1 +
>  4 files changed, 330 insertions(+)
>  create mode 100755 tests/ext4/030
>  create mode 100644 tests/ext4/030.out
>
> diff --git a/common/rc b/common/rc
> index 9216efdb..052dadae 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1845,6 +1845,29 @@ _require_scratch_ext4_feature()
>      _scratch_unmount
>  }
>
> +# Check whether the specified feature whether it is supported by
> +# mkfs.ext4 and the kernel by using a sparse file image.
> +_require_ext4_feature()

1. please explain why this loop variant is needed
2. it would be great if you could also change callers to
_require_scratch_ext4_feature
    to use _require_scratch_feature and plug
_require_scratch_ext4_feature in there
3. probably best to post this as a separate patch from the test itself

> +{
> +    if [ -z "$1" ]; then
> +        echo "Usage: _require_loop_ext4_feature feature"

So which is it, _require_loop_ext4_feature or _require_ext4_feature?
First one sounds better to me, given that you explain why the loop
variant is needed.
If it is needed, will it be useful to have for other fs?
Then better implement _require_loop_feature and make ext4
a specific case.

Cheers,
Amir.
