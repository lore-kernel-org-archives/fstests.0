Return-Path: <SRS0=V6JG=AR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63184C433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A62073E
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594051772;
	bh=34nW5G+JYldoenwuGTrXHpilWnX8DGeEBmO3uF6Yp6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=AEF4ynG0ilvXAlXTl2RWCPGzhAX9HLVMOXu5S+gDPDTazRiCwX/rTNF9rnFF46Dor
	 MMT3RmSaw0VHf/BRgxXtdZ0/0Ev5gDvPajdZcHrg/HOCw4lMbxVJOKeukmakkeJZT5
	 8Gm6MxJOkdiSdDAswQt8Gv/zsGaaR7nl07qX6xts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGFQJc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFQJb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 6 Jul 2020 12:09:31 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C43FA20708;
        Mon,  6 Jul 2020 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594051771;
        bh=34nW5G+JYldoenwuGTrXHpilWnX8DGeEBmO3uF6Yp6Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xusRbDMpPTThSDcvGnTdXoPPqReSkBUG1FvIzjs2BigqBvd87sBG/VOK3wli60txs
         bXbJrdnOEbt+HoIklmcD6Yqvu40V1OjJEylmgKBy8MVvwlv+WHjlOuY2sIIua+26Ff
         JT/u+1Y7roEAdNgzAvzxWcDyxkI8Wic9l5iuxIW4=
Message-ID: <b78b79138ea7761d7ef3482a34d072947d998aa1.camel@kernel.org>
Subject: Re: [PATCH] generic/062: use more restrictive filter when querying
 for attributes
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Date:   Mon, 06 Jul 2020 12:09:29 -0400
In-Reply-To: <20200706153247.65936-1-jlayton@kernel.org>
References: <20200706153247.65936-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 2020-07-06 at 11:32 -0400, Jeff Layton wrote:
> Sometimes we can end up with unexpected xattrs showing up on an inode.
> For instance, on an SELinux-enabled host security.selinux may be set and
> show up in a listing even though we've never set it.
> 
> generic/062 lists out all of the xattrs on an inode in some cases, but
> it can't easily account for these "automatic" xattrs being set. Change
> it to use a more restrictive regex when filtering attributes, so that we
> just get the namespaces we're interested in.
> 
> Cc: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/062 | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/062 b/tests/generic/062
> index d2a0ac9a9a21..cab4b4faac7c 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -77,8 +77,10 @@ invalid_attribute_filter() {
>  
>  if [ "$USE_ATTR_SECURE" = yes ]; then
>      ATTR_MODES="user security trusted"
> +    ATTR_FILTER="^(user|security|trusted)"
>  else
>      ATTR_MODES="user trusted"
> +    ATTR_FILTER="^(user|trusted)"

These should probably be a bit more restrictive so that we include the
'.' delimiter:

	ATTR_FILTER="^(user|trusted)\\."

I'll send that in a v2 once I give people a chance to comment on the
rest.

>  fi
>  for nsp in $ATTR_MODES; do
>  	for inode in reg dir lnk dev/b dev/c dev/p; do
> @@ -121,7 +123,7 @@ for nsp in $ATTR_MODES; do
>  		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
>  
>  		echo "*** final list (strings, type=$inode, nsp=$nsp)"
> -		getfattr -m '.' -e hex $SCRATCH_MNT/$inode
> +		getfattr -m $ATTR_FILTER -e hex $SCRATCH_MNT/$inode
>  	
>  	done
>  done
> @@ -151,11 +153,11 @@ _extend_test_bed
>  
>  echo
>  echo "*** directory descent with us following symlinks"
> -getfattr -h -L -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
> +getfattr -h -L -R -m $ATTR_FILTER -e hex $SCRATCH_MNT | _sort_getfattr_output
>  
>  echo
>  echo "*** directory descent without following symlinks"
> -getfattr -h -P -R -m '.' -e hex $SCRATCH_MNT | _sort_getfattr_output
> +getfattr -h -P -R -m "$ATTR_FILTER -e hex $SCRATCH_MNT | _sort_getfattr_output
>  
>  # 
>  # Test the backup/restore code
> @@ -168,7 +170,7 @@ _backup()
>  	# we *do* sort the output by path, since it otherwise would depend on
>  	# readdir order, which on some filesystems may change after re-creating
>  	# the files.
> -	_getfattr --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
> +	_getfattr --absolute-names -dh -R -m $ATTR_FILTER $SCRATCH_MNT | _sort_getfattr_output >$1
>  	echo BACKUP $1 >>$seqres.full
>  	cat $1 >> $seqres.full
>  	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"

-- 
Jeff Layton <jlayton@kernel.org>

