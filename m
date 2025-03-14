Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9C12B63
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968963; cv=none; b=nGjLCbYi+huxvfDGnAcEDOOfgbz1rXoin7SdBblAF3RDuxwgSN03PoOvvVeVcpvPuO13SqE/xhKA2zZ78Sc4tJmDl1Wc+C5Cyc6d6Ad4qK/iFROzEOzeDKGtToK8ab3A8MOBx10G7gFI4FdhQPObBR25+SwQsArtL7L9gIVa7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968963; c=relaxed/simple;
	bh=XM33nyTWcSSBV+t0v5V+vTuJr5I5UCC9pXw+6+e2/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t93aM+GTbfODksQvxxVf2RaXv02+Uw5wvhXo+2MB04IHOD7R/Z4Bv3cmOQW1LhwZho7TkPXUmVVyE0UYBaJ+ztPrYeCqzeSgE84Ae+hfRFj/cjH5gFcNx574qyojIgrf6+HZWbAnLWtOGUzNZkAwQ9klbGWyir9TSEqM6AIp7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWugQPOz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWugQPOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741968960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpiwrWhX7WwD9ZoVVpBx/Ka7EmuZOQFlBemNybH836k=;
	b=aWugQPOzgmrZ6mOO/3JeQpnq8CsnbklPBFvvpP5iBF8c5JgHMKOeu5pjjFe3jJPSJSX39g
	4vXbwm9Fin4p/cnB1mBg5qURrXr+3hnonUWrKO0iwgrB/9SBL9kOwzHIm5dJW0+SFtF9FP
	izo0jXHru4DcPFKhggwgcVxnFqXAzQ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-ICzhVx5_Ncmb7oChlfCd2w-1; Fri,
 14 Mar 2025 12:15:57 -0400
X-MC-Unique: ICzhVx5_Ncmb7oChlfCd2w-1
X-Mimecast-MFC-AGG-ID: ICzhVx5_Ncmb7oChlfCd2w_1741968956
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C8741809CA5;
	Fri, 14 Mar 2025 16:15:56 +0000 (UTC)
Received: from redhat.com (unknown [10.22.64.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16D3F300376F;
	Fri, 14 Mar 2025 16:15:54 +0000 (UTC)
Date: Fri, 14 Mar 2025 11:15:52 -0500
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] fstests: test for CONFIG_QFMT_V2 in _require_quota
Message-ID: <qxrk5tfu3e2deg7ij23tjn4ggilmwsb4md6h3aphzb6ney3hfe@rkd5wottjpij>
References: <5637d8c8-d92e-43b0-95b6-a8decc5e2025@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5637d8c8-d92e-43b0-95b6-a8decc5e2025@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Mar 14, 2025 at 10:44:16AM -0500, Eric Sandeen wrote:
> When CONFIG_QUOTA is enabled but CONFIG_QFMT_V2 is disabled in the
> kernel config, many quota tests on ext4 will fail in odd ways,
> when in fact they should be _notrun. Add a CONFIG_QFMT_V2 test to
> _require_quota() to catch this for filesystems that require it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks fine.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> ---
> 
> V2: add _require_quota to ext4/055, because it adds the -O quota
> feature at mkfs time, and mount fails without CONFIG_QFMT_V2.
> Jan, I took the liberty of leaving your RVB: despite that minor change,
> please let me know if you object. Thanks!
> 
> diff --git a/common/quota b/common/quota
> index e306e2e3..a51386b1 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -16,6 +16,7 @@ _require_quota()
>  	if [ ! -d /proc/sys/fs/quota ]; then
>  	    _notrun "Installed kernel does not support quotas"
>  	fi
> +	_require_kernel_config CONFIG_QFMT_V2
>  	;;
>      gfs2|ocfs2|bcachefs)
>  	;;
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 5922ed57..77b3ac81 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -45,7 +45,6 @@ _require_loop
>  _require_command "$TUNE2FS_PROG" tune2fs
>  MKE2FS_PROG=$(type -P mke2fs)
>  _require_command "$MKE2FS_PROG" mke2fs
> -_require_kernel_config CONFIG_QFMT_V2
>  
>  LOG=""
>  print_log() {
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index 3117bf15..711d18c2 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -14,6 +14,7 @@
>  # The test is based on a testcase from Zhang Yi <yi.zhang@huawei.com>.
>  #
>  . ./common/preamble
> +. ./common/quota
>  _begin_fstest auto quota
>  
>  _exclude_fs ext2
> @@ -23,6 +24,7 @@ _require_scratch_nocheck
>  _require_user fsgqa
>  _require_user fsgqa2
>  _require_command "$DEBUGFS_PROG" debugfs
> +_require_quota
>  
>  echo "Silence is golden"
>  
> 
> 

