Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576E58106
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFgg6ZSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705005636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u63hhxKl3YY5/mbtaYFlWImH4z3XMuq7AOanD+q3Aqo=;
	b=OFgg6ZSvqPGh0eL6MqI76RJ5Ks7lBhlB3DdRQ77L+HTMi+Kntu44GScJINXyq1qRHaIp+r
	S4ryawu/FEeGUNx1OkBwOoKTOJr/Ww29edeFJaVHLi5QhHZlNQ6M4qQ1j4NfQ1sRc+lM5n
	ec0M8Vki4lwLMm0vWDgCLcNOmEKbduo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-sZCJn74UOQWyNO1y0gjDfw-1; Thu, 11 Jan 2024 15:40:34 -0500
X-MC-Unique: sZCJn74UOQWyNO1y0gjDfw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9ba60e1c1so3889023b3a.3
        for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 12:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005633; x=1705610433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u63hhxKl3YY5/mbtaYFlWImH4z3XMuq7AOanD+q3Aqo=;
        b=YZrzLnw6NEYJo9ONtm811Q2V+uRsaVjG+7wGeAIun4hQhZfINbfhYfXV2N2GSI2zNg
         3vAXcQM9qOypqz1qnVaBmTS0JIaKInyTSIMvjpn5fnTNp26xryp8847UavDQ3vMh61Yd
         oJXUt7JjQLZ3a8nUsi6p3AE+rPRQ+mAgtiUsvlCznQjGmY1TyXC6mxKp+Jj3cBll77nv
         YI1/AJQ96lDQkxTG6oMfXyvg4qD/YnizsxTL4eWZgp+MQj3Z8UwXwJxikRvVgXjPNWXL
         EmlXTEw26fZj7rcryDmOHkMP5kEE05Nlto1WSPHea3NIPE907uy23uB1qjOEptHXSeLQ
         7fyA==
X-Gm-Message-State: AOJu0YyAkQatxewlUo+9uAfuYQrDQaB7y+bb9sY3VnmebWcXsreIUxiv
	+LWVHPiGVe2OyF2Gv5MFEm8VflLdyPtpbJOrRC25iEoajmhcZIHx0K71rQ0erfNwwLfH87P5Zpl
	kq0yD5Unuttb8hcrZS2vKt1V9Sg==
X-Received: by 2002:a05:6a00:ac6:b0:6d9:94b6:7b47 with SMTP id c6-20020a056a000ac600b006d994b67b47mr374699pfl.60.1705005633469;
        Thu, 11 Jan 2024 12:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs28i6AjZhEli8pfvLzZ1p6FYFN5L0G9x5U6zzB137UY22Xu48/rQisvpPlKAfI9TvoqEZJg==
X-Received: by 2002:a05:6a00:ac6:b0:6d9:94b6:7b47 with SMTP id c6-20020a056a000ac600b006d994b67b47mr374691pfl.60.1705005633131;
        Thu, 11 Jan 2024 12:40:33 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b006d9a0902934sm1620847pfn.70.2024.01.11.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:40:32 -0800 (PST)
Date: Fri, 12 Jan 2024 04:40:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] gfs2: Recognize block size in _scratch_mkfs_sized
Message-ID: <20240111204029.25tc45keqjtfbodn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240111152730.4339-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152730.4339-1-agruenba@redhat.com>

On Thu, Jan 11, 2024 at 04:27:30PM +0100, Andreas Gruenbacher wrote:
> Fix the block size recognition logic in _scratch_mkfs_sized() to work
> for gfs2 as well.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index cc92fe06..9d947df2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -931,7 +931,7 @@ _scratch_mkfs_sized()
>  	btrfs)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
>  		;;
> -	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs)
> +	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs|gfs2)
>  		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`

OK, by checking the mkfs.gfs2 manual, it really uses "-b <BlockSize>" to specify
a blocksize. So this fix makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  		;;
>  	udf)
> -- 
> 2.43.0
> 
> 

