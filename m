Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9AEC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 01:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiFBBEk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 21:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiFBBEk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 21:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F12629D6
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 18:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E0E615D7
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 01:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF0BC385A5;
        Thu,  2 Jun 2022 01:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131878;
        bh=lXOk+KWDR2A1fRU90FvilyNrsKWoj9MmM7UtnAorEG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzlmXY/wB3sjOLGA+BJp9uNIRAJPsw9fErYAk3yH/Wqoqhou+z3/Ne8xKWcl2VudU
         2nGhCT1hGh8gN6xJfngMdyNWk1aL3p2xUk/g7wO1q3fWHVLQH2GdXtWfH/s83jKexZ
         KeZehAAoTWIIaSBTIeHZT9QyzHujbr9web8rk/LY+HzpvJvWDmDrNXzmBQG6MsoMgk
         8rI4FzQ//ruqVrdRNiT14O5AvEnvtkjfAEjD0dhJwP43kPtLDT1/7iR7i2Iho6BICl
         UbBrodJyMaROgDwQzmEhiaMVuX6JbdtS+obcjXm3uo9Hs230NidrGZ65oiphZ68Dnv
         yRwuUda80r1Jg==
Date:   Wed, 1 Jun 2022 18:04:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 8/8] xfs/189: systemd monitoring of /etc/fstab sucks
Message-ID: <YpgMpcHKT+hnuG89@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-9-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:26AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> On a recently upgraded system, xfs/189 still works just fine, but
> every test run after it now gets spammed from mount/systemd
> like so:
> 
> xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
> xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  1s
> xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  2s
> xfs/193 2s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  2s
> xfs/194 1s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
> 
> This is because xfs/189 modifies /etc/fstab during the test, then
> restores it to it's original condition so there's nothing to update.
> However, systemd is sees that the mtime of /etc/fstab has changed,
> and assumes they sky has fallen and so everything must be reloaded
> from scratch to silence the unnecessary "hint".
> 
> We can avoid this clumsiness by capturing the mtime of /etc/fstab
> before we modify it, and restore it afterwards and that means
> systemd doesn't even notice that we've being playing around with
> /etc/fstab.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/189 | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/189 b/tests/xfs/189
> index e601881a..6287a733 100755
> --- a/tests/xfs/189
> +++ b/tests/xfs/189
> @@ -32,6 +32,27 @@
>  #
>  # <---- Normal programming is resumed ---->
>  #
> +# <---- Bbbzzzzzzztttt ---->
> +#
> +# < systemd enters the chat >
> +#
> +# xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
> +# xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
> +#        the old version; use 'systemctl daemon-reload' to reload.
> +#  1s
> +#  xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
> +#        the old version; use 'systemctl daemon-reload' to reload.
> +#
> +# So now mount/systemd sees that /etc/fstab has changed (because mtime changed)
> +# and so it now whines that it needs updating on every mount from this point
> +# onwards. Yes, that's totally obnoxious behaviour from mount/systemd but we
> +# have to work around it.
> +#
> +# Hence we save/restore the mtime of /etc/fstab around every modification we
> +# make so that any time /etc/fstab is checked in future it won't appear to have
> +# changed.
> +#
> +# < systemd leaves the chat >
>  #
>  . ./common/preamble
>  _begin_fstest mount auto quick
> @@ -190,31 +211,46 @@ ENDL
>  # Example fstab entry
>  # /dev/sdb2            /mnt/scratch1        xfs       defaults 0 0
>  #
> +# Note that to avoid systemd whinging about /etc/fstab being modified, we
> +# need to ensure the mtime of /etc/fstab does not change across all these
> +# modifications.

systemd chose to create .mount units to represent filesystems that
should be mounted.  These units are owned by system packages, and
systemd *is* supposed to notice when changes are made to these files:

$ ls /lib/systemd/system/*.mount
/lib/systemd/system/dev-hugepages.mount
/lib/systemd/system/dev-mqueue.mount
/lib/systemd/system/proc-sys-fs-binfmt_misc.mount
/lib/systemd/system/sys-fs-fuse-connections.mount
/lib/systemd/system/sys-kernel-config.mount
/lib/systemd/system/sys-kernel-debug.mount
/lib/systemd/system/sys-kernel-tracing.mount
<etc>

For compatibility reasons, it synthesizes .mount units from /etc/fstab
at boot time (since the whole world still uses fstab):

$ cat /etc/fstab
/dev/mapper/flax-root /               xfs     defaults        0       0
/dev/mapper/flax.boot /boot           xfs     defaults        0       0
UUID=6C22-4885  /boot/efi       vfat    umask=0077      0       1

$ ls /run/systemd/generator/*.mount
/run/systemd/generator/boot-efi.mount
/run/systemd/generator/boot.mount
/run/systemd/generator/-.mount

systemd doesn't claim ownership of fstab (since you /could/ edit the
generated files), which means that it won't rewrite the generated .mount
files when fstab changes for fear of erasing something the sysadmin
actually changed in /run/systemd.

The annoying message you get from mount is, as you say, because the
mtime of /etc/fstab is newer than the generated files.  (This is also
why systemd had that godawful misbehavior where you'd update fstab for
an unmounted fs, mount it, and systemd would immediately unmount it,
because the device name doesn't match the un-updated .mount file).

That said, I think the proper solution here is to tell systemd to
regenerate its .mount files:

	command -v systemctl 2>/dev/null && systemctl daemon-reload

Not hack around it by futzing with the mtime.

--D

> +#
>  _add_scratch_fstab()
>  {
> +	local mtime="$(stat -c %y /etc/fstab)"
> +
>  	# comment out any existing SCRATCH_DEV
>  	$SED_PROG -i "s;$SCRATCH_DEV;#$SCRATCH_DEV;" /etc/fstab
>  
>  	# add our fstab entry
>  	echo "$SCRATCH_DEV $SCRATCH_MNT xfs defaults 0 0 # $tag" >> /etc/fstab
> +
> +	touch -m --date="$mtime" /etc/fstab
>  }
>  
>  _modify_scratch_fstab()
>  {
> -	opts=$1
> +	local opts=$1
> +	local mtime="$(stat -c %y /etc/fstab)"
>  
>  	# modify our fstab entry that we added
>  	# modify opts by looking for last word which has non-space chars
>  	$SED_PROG -i "s; [^ ]* 0 0 # $tag; $opts 0 0 # $tag;" /etc/fstab
> +
> +	touch -m --date="$mtime" /etc/fstab
>  }
>  
>  _putback_scratch_fstab()
>  {
> +	local mtime="$(stat -c %y /etc/fstab)"
> +
>  	# uncomment out any existing SCRATCH_DEV
>  	$SED_PROG -i "s;#$SCRATCH_DEV;$SCRATCH_DEV;" /etc/fstab
>  
>  	# remove the one we added at the end
>  	$SED_PROG -i "/# $tag/d" /etc/fstab
> +
> +	touch -m --date="$mtime" /etc/fstab
>  }
>  
>  # Import common functions.
> -- 
> 2.35.1
> 
