Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1g6FuLy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF8189
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700152199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DwJS6zdLyYXkUVdq8gyazpBXqUqtthlCUIgpjsPXKSI=;
	b=U1g6FuLyB6jIqWIhzGbh6gL5JoCDrr/N2ktC+Eslw957E6jgILr2wrTOu2uMUy+rnhOhQY
	E+FTur/0fMJb6MhzbHSOuMOSSpBKCJ0fDMaT2hiao/vVZi5tf62elqn9hRkrlno+/lJwYy
	sdZfrHPXqTVpHYgcyRz57YPH4B+DapQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-FF07jtqHOn2J1OxVa9ReQQ-1; Thu, 16 Nov 2023 11:29:56 -0500
X-MC-Unique: FF07jtqHOn2J1OxVa9ReQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C6C7811E7D;
	Thu, 16 Nov 2023 16:29:56 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.219])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E06E12166B28;
	Thu, 16 Nov 2023 16:29:55 +0000 (UTC)
Date: Thu, 16 Nov 2023 10:29:54 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs/263: Remove mkfs.xfs data section argument
Message-ID: <ZVZDggsGz0bA7E0X@redhat.com>
References: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Nov 16, 2023 at 02:33:15AM -0500, Yang Xu wrote:
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
> But, since xfstests commit baaa392c("xfs/263: don't hardcode inode numbers in output"),
> we don't care the inode number. So let's remove this data section size argument
> instead of increasing this size to 1G, then we can solve this false
> positive.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> ---
>  tests/xfs/263 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index fadd6280..bce4e13f 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -72,12 +72,11 @@ function test_all_state()
>  }
>  
>  echo "==== NO CRC ===="
> -# Control size to control inode numbers
> -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> +_scratch_mkfs_xfs "-m crc=0 -n ftype=0" >> $seqres.full
>  test_all_state
>  
>  echo "==== CRC ===="
> -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1" >>$seqres.full
>  test_all_state
>  
>  status=0
> -- 
> 2.39.1
> 
> 

