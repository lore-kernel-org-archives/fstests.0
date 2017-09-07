Received: from mx1.redhat.com ([209.132.183.28]:57748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754109AbdIGHrl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Sep 2017 03:47:41 -0400
Date: Thu, 7 Sep 2017 15:47:39 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 09/13] fstests: add support for working with
 dm-log-writes target
Message-ID: <20170907074739.GM8034@eguan.usersys.redhat.com>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-10-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504638680-25682-10-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 05, 2017 at 10:11:16PM +0300, Amir Goldstein wrote:
> Cherry-picked the relevant common bits from commit 70d41e17164b
> in Josef Bacik's fstests tree (https://github.com/josefbacik/fstests).
> Quoting from Josef's commit message:
> 
>   This patch adds the supporting code for using the dm-log-writes
>   target.  The dmlogwrites code is similar to the dmflakey code, it just
>   gives us functions to build and tear down a dm-log-writes target.  We
>   add a new LOGWRITES_DEV variable to take in the device we will use as
>   the log and add checks for that.
> 
> [Amir:]
> - Removed unneeded _test_falloc_support
> - Moved _require_log_writes to dmlogwrites
> - Document _require_log_writes
> - Address review comments by Eryu Guan
> 
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

...

> +# _replay_log <mark>

One additional nit, this comment can be updated to reflect new name :)

> +#
> +# This replays the log contained on $LOGWRITES_DEV onto $SCRATCH_DEV upto the
> +# mark passed in.
> +_log_writes_replay_log()

Thanks,
Eryu
