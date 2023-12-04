Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG5CNero"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13398109
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701713025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEhSjs54nO8InvY+sUNJmDqysmSb2BVyoKp37NKJFbw=;
	b=aG5CNerowOBsm1wtuENorUaXhd+Frh5iKj7Zr0An9amo5Wwb8l6q+ZP235WC6MHs9Po/J5
	5LiCdeg4K+jnvteiLKwQXVld4V1/BznaESP9FQZtYVDn18eHtOXI+4sV5x+oi+jUm2OhCM
	eaMKrnNKcLhvogc49RB04J4K4JQ7vfU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-5PKIQLm5P5OzoDBBRyS4pA-1; Mon, 04 Dec 2023 13:03:39 -0500
X-MC-Unique: 5PKIQLm5P5OzoDBBRyS4pA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2866c800dd5so3292363a91.0
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2023 10:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713018; x=1702317818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEhSjs54nO8InvY+sUNJmDqysmSb2BVyoKp37NKJFbw=;
        b=hHvmQw9BIPrWUyWGcxZ6emuD5Do2vXmkFryYJmBOHSmXgOHN3QCIyuIV0Ht43ruBo9
         /qFW55QrdOoqDfYkmfHMvJdreVVZLeo+1ucTe6wT22nDzFiliXdKUQxvg78ObLwbblMS
         flfKRhhcL+sz3iII5U3kLPT0vQ5cLAGeYftB+PK9idQT6zt0tyHqwJEMvjESoWeDjHke
         /QrNghGp5lWmYfAj5hRHsZreg99CIIOv5RglLF02pHSu//oD+LTcl3a6FnxjLsS3DrEg
         fh4e4xLFKR1lJ7MGLIbGZiQ2oJ/ux7RhEkPumVBvIBl5sw5htf4WRzFA3sW6sWKt024l
         L2sQ==
X-Gm-Message-State: AOJu0Yzg/vStCuST3wLSvPY2+ukoUoAvX8jbkyvwULoq5QrRSKfOMcmw
	eH/kENXaoSJohWXBLrXIXzKNuf5NjV7O5Ex86gSJl002zR2CBFGFRnhu6YAxXGVI7a/0GCtX7bH
	/4E+TPx7O0k29r3suk1Q6FgEH3pRnSdk=
X-Received: by 2002:a17:90a:de8c:b0:286:6cc0:cae1 with SMTP id n12-20020a17090ade8c00b002866cc0cae1mr3195190pjv.88.1701713018395;
        Mon, 04 Dec 2023 10:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8HMPc0sGd+lSFBbe6RxYaY900yBM9NEDJabmoBq/DInD6Ago7d6g2nc046Zj6mbokrn9vVQ==
X-Received: by 2002:a17:90a:de8c:b0:286:6cc0:cae1 with SMTP id n12-20020a17090ade8c00b002866cc0cae1mr3195179pjv.88.1701713018120;
        Mon, 04 Dec 2023 10:03:38 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b002867adefbd4sm3937115pjo.48.2023.12.04.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:03:37 -0800 (PST)
Date: Tue, 5 Dec 2023 02:03:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs/048: add missing groups 'subvol', 'snapshot'
 and 'send'
Message-ID: <20231204180334.czfdn4y5zi2qpltb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1701704557.git.fdmanana@suse.com>
 <bb893d210f2cb43467f219a817003cbd6b596b6c.1701704559.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb893d210f2cb43467f219a817003cbd6b596b6c.1701704559.git.fdmanana@suse.com>

On Mon, Dec 04, 2023 at 03:45:11PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test case exercises subvolumes, snapshot and send/receive, so add
> the corresponding groups to the test.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/048 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 7816a997..8a88b8cc 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -11,7 +11,7 @@
>  #  btrfs: fix zstd compression parameter
>  #
>  . ./common/preamble
> -_begin_fstest auto quick compress
> +_begin_fstest auto quick compress subvol snapshot send
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.40.1
> 
> 

