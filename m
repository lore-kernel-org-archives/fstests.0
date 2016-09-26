Received: from mail-wm0-f65.google.com ([74.125.82.65]:35195 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965343AbcIZJL1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Sep 2016 05:11:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so13064910wmq.2
        for <fstests@vger.kernel.org>; Mon, 26 Sep 2016 02:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1474649676-31602-1-git-send-email-eguan@redhat.com>
References: <1474649676-31602-1-git-send-email-eguan@redhat.com>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 26 Sep 2016 12:11:24 +0300
Message-ID: <CADxRZqyaupU9ThvAcT7w7vu5LUgV=eGLDSmN2ZXb3By4iYDs5g@mail.gmail.com>
Subject: Re: [PATCH] generic/317: use id to get user id
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 23, 2016 at 7:54 PM, Eryu Guan <eguan@redhat.com> wrote:
>
> Greping username "fsgqa" in passwd file to get user id doesn't
> always work, because the given username could match multiple
> entries, e.g. when we have user "123456-fsgqa" (used by other tests)
> in passwd file.
>
> Fix it by using "id -u $qa_user" to get the user id directly.
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/317 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/317 b/tests/generic/317
> index 9d9499b..7e40b1f 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -61,7 +61,7 @@ _require_scratch
>  _require_user
>  _require_ugid_map
>  _require_userns
> -qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
> +qa_user_id=`id -u $qa_user`


shouldn't it use _cat_passwd() from common/rc ?
