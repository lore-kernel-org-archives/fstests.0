Received: from mail-yw0-f195.google.com ([209.85.161.195]:35544 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbdHWP6j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2017 11:58:39 -0400
MIME-Version: 1.0
In-Reply-To: <1503503357-26234-8-git-send-email-amir73il@gmail.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com> <1503503357-26234-8-git-send-email-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Aug 2017 18:58:38 +0300
Message-ID: <CAOQ4uxiq=b0SeSK17_6d_uPw8owbyNQkkeTiPBUwaVYHpMgQGQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/8] fstests: add support for working with
 dm-log-writes target
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 23, 2017 at 6:49 PM, Amir Goldstein <amir73il@gmail.com> wrote:
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
>
> Cc: Josef Bacik <jbacik@fb.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  README                       |  2 ++
>  common/dmlogwrites           | 86 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/requirement-checking.txt | 20 +++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 common/dmlogwrites
>

...

> +
> +_init_log_writes()
> +{
> +       local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> +       LOGWRITES_NAME=logwrites-test
> +       LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
> +       LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $SCRATCH_DEV $LOGWRITES_DEV"
> +       $DMSETUP_PROG create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
> +               _fatal "failed to create log-writes device"
> +       $DMSETUP_PROG mknodes > /dev/null 2>&1
> +}
> +
...
> +_cleanup_log_writes()
> +{
> +       # If dmsetup load fails then we need to make sure to do resume here
> +       # otherwise the umount will hang

Josef,

Care to explain this comment?
What do you mean by "resume" here? is this a real concern?

> +       $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> +       _log_writes_remove
> +}
