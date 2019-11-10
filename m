Return-Path: <SRS0=7tTV=ZC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574D4C43331
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D29820842
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 14:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c07y5DWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfKJOLD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Nov 2019 09:11:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35763 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfKJOLD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Nov 2019 09:11:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13so8584543pfq.2
        for <fstests@vger.kernel.org>; Sun, 10 Nov 2019 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mpFVceqE4AZpEDI2JwKcBlnF1E2paoSk/mNauoYhlc=;
        b=c07y5DWzsnq2gJxUOEsXgvb09RsxAGerg1cmPif/WhTEDhn+EZYBAHJ+Lb1+wi+PQQ
         4hOq/KY4uzXOrNAsEO/wwcA5D+60JwJ+9pr7P30qJvN/e24QpyjNgqSRPdYFLXn3F/Zq
         reSb4a5kpfiLCfI6zKFQ/Xk3Wg2fukKSq0mDvLTzxEu753W+jSgRnWYQaQgQWtEDaXmm
         kh8NeVYEHn2dlXwFuQ3bs96FWwrf3j5B9ZAGyC6UeLiY+cs60WTjAyQGufEKZbp+yry8
         ILvH7wCob0D1mRXNeAH5IuMX0plLjEAUc8eQksDVTMY+Fmf6MYY+pcC7rhIhP3VJ2yBU
         EAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mpFVceqE4AZpEDI2JwKcBlnF1E2paoSk/mNauoYhlc=;
        b=mxaVXn2s6XmfyxxMB2Sh7zZITXsRzSVBqsZa3rnapMt/CdW7Q/mxp+wa8e7a4HMoBY
         RLrSMQtWj2B7Pwl2CRBxRSQ/8lTz9P/nEY5Q5Qfp87lon4YsBR7x/fkyNVjm4+Xjrhyl
         QS+SURYJNVFHxJfE2uP86JyaFVpP1g8HrB0Le7spRnCOZkzLAIWdBZ7vkgOFCdOPlIg/
         4qhWL1ci8GqZjwv9uhNEqkXqb7r+gW2c4RmY9nBh3MwMvOyWQKusWSAL9S1FLngsDjkD
         HMEJf7zdQb3pwrNPBpkpM9x7cvDTyNqwc06VmK09igXCYlJEnryzJraMaM7nNtB2gQE2
         uRnw==
X-Gm-Message-State: APjAAAVKuqrxKqOUZojy9kQ4+IxO94KqB34FuoHln84s0KYRnWw5oSHa
        +ZsmpDjObmGDFhzqLUimD8I=
X-Google-Smtp-Source: APXvYqwuZvJM44cF1SfUIIPQOXfXkIY/rKa+ldtJlz0zkAHfiPkvrVGR3awjHLwTDr2wdIeQCyCKRg==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr10790852pfp.51.1573395060899;
        Sun, 10 Nov 2019 06:11:00 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id u7sm12293327pfh.84.2019.11.10.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 06:10:59 -0800 (PST)
Date:   Sun, 10 Nov 2019 22:10:54 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] generic/050: Handle xfs quota special case with
 different output
Message-ID: <20191110141052.GE8664@desktop>
References: <20191105131922.24848-1-jack@suse.cz>
 <20191105131922.24848-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105131922.24848-3-jack@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

[cc'ed Darrick for his inputs, if there's any]

On Tue, Nov 05, 2019 at 02:19:22PM +0100, Jan Kara wrote:
> Instead of faking output for the case of XFS with quotas, just use a
> different output file with appropriate output.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/050              | 29 ++++++-----------------------
>  tests/generic/050.cfg          |  1 +
>  tests/generic/050.out.xfsquota | 22 ++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 23 deletions(-)
>  create mode 100644 tests/generic/050.out.xfsquota
> 
> diff --git a/tests/generic/050 b/tests/generic/050
> index a8d648e5eede..c5375805fd7a 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -39,27 +39,15 @@ _require_norecovery
>  features=""
>  if ! _has_metadata_journaling $SCRATCH_DEV >/dev/null; then
>  	features="nojournal"
> +elif [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
> +	# Mounting with quota on XFS requires a writable fs, which means
> +	# we expect to fail the ro blockdev test with with EPERM.
> +	features="xfsquota"

Given that we already have a non-default output for "nojournal" feature,
this looks fine to me.

>  fi
>  _link_out_file "$features"
>  
>  _scratch_mkfs >/dev/null 2>&1
>  
> -filter_ro_mount() {
> -	local arg=""
> -
> -	if [ -n "$expect_mount_failure" ]; then
> -		arg="s|mount: $SCRATCH_MNT: permission denied|mount: device write-protected, mounting read-only|g"
> -	fi
> -	sed -e "$arg" | _filter_ro_mount
> -}
> -
> -# Mounting with quota on XFS requires a writable fs, which means
> -# we expect to fail the ro blockdev test with with EPERM.
> -expect_mount_failure=
> -if [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
> -	expect_mount_failure=1
> -fi
> -
>  #
>  # Mark the device read-only
>  #
> @@ -70,7 +58,7 @@ blockdev --setro $SCRATCH_DEV
>  # Mount it, and make sure we can't write to it, and we can unmount it again
>  #
>  echo "mounting read-only block device:"
> -_try_scratch_mount 2>&1 | filter_ro_mount
> +_try_scratch_mount 2>&1 | _filter_ro_mount
>  if [ "${PIPESTATUS[0]}" -eq 0 ]; then

But I think we could remove above check as a whole, just do

_try_scratch_mount 2>&1 | _filter_ro_mount
echo "touching file on read-only filesystem (should fail)"
touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
echo "unmounting read-only filesystem"
_scratch_unmount 2>&1 | _filter_scratch

as what we did prior to commit b0415daaa968 ("generic/050: fix ro
blockdev mount of xfs with quota").

>  	echo "touching file on read-only filesystem (should fail)"
>  	touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> @@ -81,11 +69,6 @@ if [ "${PIPESTATUS[0]}" -eq 0 ]; then
>  	#
>  	echo "unmounting read-only filesystem"
>  	_scratch_unmount 2>&1 | _filter_scratch
> -elif [ -n "${expect_mount_failure}" ]; then
> -	# Mount failed, so simulate EROFS instead of scribbling on root fs
> -	echo "touching file on read-only filesystem (should fail)"
> -	echo "touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system"
> -	echo "unmounting read-only filesystem"
>  else
>  	echo "Mount failed, though it wasn't supposed to!"
>  fi

So this message could be removed too, which is confusing in xfsquota
case, and _scratch_unmount error message would break golden image in
non-xfsquota case.

> @@ -124,7 +107,7 @@ _scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
>  # data recovery hack.
>  #
>  echo "mounting filesystem with -o norecovery on a read-only device:"
> -_try_scratch_mount -o norecovery 2>&1 | filter_ro_mount
> +_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount
>  if [ "${PIPESTATUS[0]}" -eq 0 ]; then
>  	echo "unmounting read-only filesystem"
>  	_scratch_unmount 2>&1 | _filter_scratch
> diff --git a/tests/generic/050.cfg b/tests/generic/050.cfg
> index c76bd473873b..1d9d60bc69a0 100644
> --- a/tests/generic/050.cfg
> +++ b/tests/generic/050.cfg
> @@ -1 +1,2 @@
>  nojournal: nojournal
> +xfsquota: xfsquota
> diff --git a/tests/generic/050.out.xfsquota b/tests/generic/050.out.xfsquota
> new file mode 100644
> index 000000000000..1a90d525c40a
> --- /dev/null
> +++ b/tests/generic/050.out.xfsquota
> @@ -0,0 +1,22 @@
> +QA output created by 050
> +setting device read-only
> +mounting read-only block device:
> +mount: /mnt-scratch: permission denied
> +Mount failed, though it wasn't supposed to!

This is confusing, we expect a mount failure in xfsquota case.

Thanks,
Eryu

> +setting device read-write
> +mounting read-write block device:
> +touch files
> +going down:
> +unmounting shutdown filesystem:
> +setting device read-only
> +mounting filesystem that needs recovery on a read-only device:
> +mount: device write-protected, mounting read-only
> +mount: cannot mount device read-only
> +unmounting read-only filesystem
> +umount: SCRATCH_DEV: not mounted
> +mounting filesystem with -o norecovery on a read-only device:
> +mount: /mnt-scratch: permission denied
> +Mount failed, though it wasn't supposed to!
> +setting device read-write
> +mounting filesystem that needs recovery with -o ro:
> +*** done
> -- 
> 2.16.4
> 
