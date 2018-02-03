Received: from mail-pl0-f66.google.com ([209.85.160.66]:42896 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeBCFGg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Feb 2018 00:06:36 -0500
Received: by mail-pl0-f66.google.com with SMTP id 11so7763857plc.9
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2018 21:06:36 -0800 (PST)
Date: Sat, 3 Feb 2018 13:06:28 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] generic/307: Require ACL support
Message-ID: <20180203050628.GA23125@eguan.usersys.redhat.com>
References: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
 <1517320499-14714-2-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517320499-14714-2-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 30, 2018 at 01:54:58PM +0000, Rostislav Skudnov wrote:
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
> ---
>  tests/generic/307 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/307 b/tests/generic/307
> index f5d0680..bbdc70f 100755
> --- a/tests/generic/307
> +++ b/tests/generic/307
> @@ -51,6 +51,7 @@ testfile=$SCRATCH_MNT/testfile.$seq
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_acls

I added ". common/attr" to use _require_acls, as I saw failure in my
release testing:

+./tests/generic/307: line 54: _require_acls: command not found

Thanks,
Eryu
