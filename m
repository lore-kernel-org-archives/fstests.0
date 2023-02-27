Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F1AC64ED6
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Feb 2023 16:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB0QPC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjB0QPA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Feb 2023 11:15:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA91ABDD
        for <fstests@vger.kernel.org>; Mon, 27 Feb 2023 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677514455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2XcQO9zBwNgY0UbCQHG/R6/WyIMUta34CRwnHspZKs=;
        b=VtTYtwnzHeAve5uTvhP24nPUL4ktD5HsEw24oV4NBGBLhFi26eZXwjtfGwnes3v5mexE9q
        u5o5ygNeHKPLAWJRMLLHFZujQFtxsL5bKYlEHofbO+kWKV5KgapdiSgMU8uC6Qvr1xMej6
        74aLkq+Dc0FFbNhkTbqOAjz8TP2CCLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Lv7xNEOnOtCFmxNszDCDlA-1; Mon, 27 Feb 2023 11:14:14 -0500
X-MC-Unique: Lv7xNEOnOtCFmxNszDCDlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B18AC8828C4;
        Mon, 27 Feb 2023 16:14:13 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 567BA492B12;
        Mon, 27 Feb 2023 16:14:13 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:14:11 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        ceph-devel@vger.kernel.org, vshankar@redhat.com, zlang@redhat.com
Subject: Re: [PATCH v2] generic/020: fix really long attr test failure for
 ceph
Message-ID: <Y/zW074aOKP3PLBh@redhat.com>
References: <20230227041358.350309-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227041358.350309-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 27, 2023 at 12:13:58PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> If the CONFIG_CEPH_FS_SECURITY_LABEL is enabled the kernel ceph
> itself will set the security.selinux extended attribute to MDS.
> And it will also eat some space of the total size.
> 
> Fixes: https://tracker.ceph.com/issues/58742
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---

LGTM
Reviewed-by Bill O'Donnell <bodonnel@redhat.com>

> 
> V2:
> - make the 'size' and the 'selinux_size' to be local
> 
>  tests/generic/020 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index be5cecad..538a24c6 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -150,9 +150,11 @@ _attr_get_maxval_size()
>  		# it imposes a maximum size for the full set of xattrs
>  		# names+values, which by default is 64K.  Compute the maximum
>  		# taking into account the already existing attributes
> -		max_attrval_size=$(getfattr --dump -e hex $filename 2>/dev/null | \
> +		local size=$(getfattr --dump -e hex $filename 2>/dev/null | \
>  			awk -F "=0x" '/^user/ {len += length($1) + length($2) / 2} END {print len}')
> -		max_attrval_size=$((65536 - $max_attrval_size - $max_attrval_namelen))
> +		local selinux_size=$(getfattr -n 'security.selinux' --dump -e hex $filename 2>/dev/null | \
> +			awk -F "=0x" '/^security/ {len += length($1) + length($2) / 2} END {print len}')
> +		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
>  		;;
>  	*)
>  		# Assume max ~1 block of attrs
> -- 
> 2.31.1
> 

