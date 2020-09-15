Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EDC2D0E3
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D6C20770
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNRKGtyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgIPAmX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgIONCs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600174966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1zVyYCe+b/y+SgfyLi42VUbYj/hsf4YX719pl/MS+g=;
        b=YNRKGtyc/5ck3/v6HMGdbji1ouuole7aNBONpyuB5179Uhf+nFLSQnvBZtk1ooPw6iW0fj
        joc5TB657OxzJBk4wP9vsdiWNBkOH5UkiqnOxrApuM21QHjGPK+Jm4/57PBrFieXZ5WBxF
        efBFMnryOw/rQl+v1Exg+8R2RwCzNqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-HyWdCa9NOWGkmDTmxOmWWg-1; Tue, 15 Sep 2020 09:02:44 -0400
X-MC-Unique: HyWdCa9NOWGkmDTmxOmWWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 451F781CAFB
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 13:02:43 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B498075138
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 13:02:42 +0000 (UTC)
Date:   Tue, 15 Sep 2020 21:16:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 03/24] generic/607: don't break on filesystems that don't
 support FSGETXATTR on dirs
Message-ID: <20200915131638.GT2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013419510.2923511.4577521065964693699.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013419510.2923511.4577521065964693699.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:15PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> This test requires that the filesystem support calling FSGETXATTR on
> regular files and directories to make sure the FS_XFLAG_DAX flag works.
> The _require_xfs_io_command tests a regular file but doesn't check
> directories, so generic/607 should do that itself.  Also fix some typos.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc         |   10 ++++++++--
>  tests/generic/607 |    5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index aa5a7409..f78b1cfc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2162,6 +2162,12 @@ _require_xfs_io_command()
>  	local testfile=$TEST_DIR/$$.xfs_io
>  	local testio
>  	case $command in
> +	"lsattr")
> +		# Test xfs_io lsattr support and filesystem FS_IOC_FSSETXATTR
> +		# support.
> +		testio=`$XFS_IO_PROG -F -f -c "lsattr $param" $testfile 2>&1`
> +		param_checked="$param"
> +		;;
>  	"chattr")
>  		if [ -z "$param" ]; then
>  			param=s
> @@ -3205,7 +3211,7 @@ _check_s_dax()
>  	if [ $exp_s_dax -eq 0 ]; then
>  		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
>  	else
> -		(( attributes & 0x2000 )) || echo "$target doen't have expected S_DAX flag"
> +		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
>  	fi
>  }
>  
> @@ -3217,7 +3223,7 @@ _check_xflag()
>  	if [ $exp_xflag -eq 0 ]; then
>  		_test_inode_flag dax $target && echo "$target has unexpected FS_XFLAG_DAX flag"
>  	else
> -		_test_inode_flag dax $target || echo "$target doen't have expected FS_XFLAG_DAX flag"
> +		_test_inode_flag dax $target || echo "$target doesn't have expected FS_XFLAG_DAX flag"
>  	fi
>  }
>  
> diff --git a/tests/generic/607 b/tests/generic/607
> index b15085ea..14d2c05f 100755
> --- a/tests/generic/607
> +++ b/tests/generic/607
> @@ -38,6 +38,11 @@ _require_scratch
>  _require_dax_iflag
>  _require_xfs_io_command "lsattr" "-v"
>  
> +# Make sure we can call FSGETXATTR on a directory...
> +output="$($XFS_IO_PROG -c "lsattr -v" $TEST_DIR 2>&1)"
> +echo "$output" | grep -q "Inappropriate ioctl for device" && \
> +	_notrun "$FSTYP: FSGETXATTR not supported on directories."
> +
>  # If a/ is +x, check that a's new children
>  # inherit +x from a/.
>  test_xflag_inheritance1()
> 

