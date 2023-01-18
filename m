Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590EDC38159
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Jan 2023 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjARP7W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjARP6j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2023 10:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB14ED29
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNmPUOg+Q6DfG4G+z/22PLD8WIx1Pvt4BSL8iZgqzP0=;
        b=LALWDYHf+icz5u/8h+xQvlgnw09A5Mr9du4XrhtbQ+B5+BKnaLScICmyeTMX7Dtkvc92+8
        oyozq9MII2y7u8zk9cd13bMqqQLjmaNiJzqJ/LDhjLYQKJnhY7ijH0ttB9QDmttUSYc/bK
        EztKq8COgYqagYO6JlgGpxE4EwztSHY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-VvJr1O4WMheWx2uy4Tjptw-1; Wed, 18 Jan 2023 10:54:09 -0500
X-MC-Unique: VvJr1O4WMheWx2uy4Tjptw-1
Received: by mail-pg1-f198.google.com with SMTP id y37-20020a634b25000000b004b1d90ea947so13617934pga.15
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 07:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNmPUOg+Q6DfG4G+z/22PLD8WIx1Pvt4BSL8iZgqzP0=;
        b=MEJ6e7DeOqHLYpCPK2t9m0A0Pj9mAVGOZBp4Pmh6n3QelHwFQQ33iFam+2fWaI++eI
         MR/+ZUz0dSLyfgg7lFygzz5GXskPxoqIp6K2qnjW6Ya651xf4VUj3qiYouPbN30i/+Hm
         i1SGzwBHHtgG1Khc+pQpyszD4SornxGfrqHo2Avp7Dk7BVi3j69ni0pmL/LxyVZr6EPk
         SED/GYomPbUncW7+UUK5opgDqaJToIX1ighyI2h9Q68CtfZViceerv5iM1YY8B1c2y3g
         5YL8sBUojnxKWWqmJBbfTSF4VtXj8e4aOLvgaLevkxe4ZCapeaADOpvdDv/pgQxHM/g7
         m1hQ==
X-Gm-Message-State: AFqh2krNIiyQkE/Bp/Nm69IhrHzS3Vy5nrK4s2C0LtUy2SMQoMdQS3P7
        A+0B1hDZt3p3P9VQck2+HtiIfvyTtwZ9/CeMHBdhqLO5VgLUmr34iCl9PCUWXJUtwxnEVJWR2fy
        C/7djGEtmn2+6QTrlww==
X-Received: by 2002:a05:6a20:d818:b0:ad:def6:af3 with SMTP id iv24-20020a056a20d81800b000addef60af3mr8353703pzb.57.1674057247861;
        Wed, 18 Jan 2023 07:54:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsHN3DO4XOuDZ4e4WUkJUeR1oUNAEboRzGPPxFCPN7285NjlnkY97mQKOKFVuVQ8hTzGHk81A==
X-Received: by 2002:a05:6a20:d818:b0:ad:def6:af3 with SMTP id iv24-20020a056a20d81800b000addef60af3mr8353685pzb.57.1674057247599;
        Wed, 18 Jan 2023 07:54:07 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r6-20020a63d906000000b004b3de07bfaasm7060047pgg.10.2023.01.18.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:54:07 -0800 (PST)
Date:   Wed, 18 Jan 2023 23:54:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] populate: improve runtime of __populate_fill_fs
Message-ID: <20230118155403.pg7aq3gtcks2ptdz@zlang-mailbox>
References: <167400103044.1915094.5935980986164675922.stgit@magnolia>
 <167400103096.1915094.8399897640768588035.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167400103096.1915094.8399897640768588035.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 17, 2023 at 04:44:33PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Run the copy loop in parallel to reduce runtime.  If filling the
> populated fs is selected (which it isn't by default in xfs/349), this
> reduces the runtime from ~18s to ~15s, since it's only making enough
> copies to reduce the free space by 5%.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/populate |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/common/populate b/common/populate
> index f34551d272..1c3c28463f 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -151,8 +151,9 @@ __populate_fill_fs() {
>  	echo "FILL FS"
>  	echo "src_sz $SRC_SZ fs_sz $FS_SZ nr $NR"
>  	seq 2 "${NR}" | while read nr; do
> -		cp -pRdu "${dir}/test/1" "${dir}/test/${nr}"
> +		cp -pRdu "${dir}/test/1" "${dir}/test/${nr}" &
>  	done
> +	wait

I'm thinking about what'll happen if we do "Ctrl+c" on a running test which
is waiting for these cp operations.

>  }
>  
>  # For XFS, force on all the quota options if quota is enabled
> 

