Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9131741
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZqnqMhL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A2B6
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700064573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/79FF3CoF/xCT+O/ByEGDghTfilDgMY6U72gYZYHq8w=;
	b=WZqnqMhL2URln99YJoUgifytsH632JOgR6ILW4dUaA+gIBxtk3yE982uZOKEJcPSgs6iOR
	U+7fWi+QKidKkTUwyMTljxMJN1EqDyxPpX5dN0AN81Bd3aypug6VDPPalde3SlqYa6EjGO
	enc6tiUCExPrNwHwRYIrEMVu/LCV5uA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-hVaeLAFAMXu2X1SGcK-x9Q-1; Wed, 15 Nov 2023 11:09:30 -0500
X-MC-Unique: hVaeLAFAMXu2X1SGcK-x9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F022851840;
	Wed, 15 Nov 2023 16:09:29 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.219])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D152492BFD;
	Wed, 15 Nov 2023 16:09:29 +0000 (UTC)
Date: Wed, 15 Nov 2023 10:09:27 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/263: increase data section size to 1024M
Message-ID: <ZVTtN5SE3qgeaMJa@redhat.com>
References: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Nov 15, 2023 at 12:56:59AM -0500, Yang Xu wrote:
> On machine with using raid, this case will trigger
> the following error:
> ==== NO CRC ====
> +mkfs.xfs: small data volume, ignoring data volume stripe unit 512 and stripe width 512
> == Options: rw ==
> == Options: usrquota,rw ==
> 
> mkfs.xfs generates this error since xfsprogs commit 42371fb36
> ("mkfs: ignore data blockdev stripe geometry for small filesystems").
> It disables automatic detection of stripe unit and width if the
> data device is less than 1GB.
> 
> To slove false poistive, just increase data section size to 1G.
     ^^^^^^^^^^^^^^^^^^^^
     solve false positive
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  tests/xfs/263 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index fadd6280..48581bac 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -73,11 +73,11 @@ function test_all_state()
>  
>  echo "==== NO CRC ===="
>  # Control size to control inode numbers
> -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> +_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=1024m" >> $seqres.full
>  test_all_state
>  
>  echo "==== CRC ===="
> -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1 -d size=1024m" >>$seqres.full
>  test_all_state
>  
>  status=0
> -- 
> 2.39.1
> 
> 

