Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vj9GNUkp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8FDFD
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701698793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNqp4EkEe81Xfk/Vi7+bb20ViDEuio2OHUZ3fwYJ9cM=;
	b=Vj9GNUkpy/aX+ejSwMi9HHMXu23lOMshw7ia3q5bhIm7B9Wx+avZkAh3OulN8Vv8tScLNJ
	krxI5xpDI/vsuhu+mH8Y4yiZqHq7kx3PffxxPow8q74fXFhlifh5F00r2MV04uieYmsJpe
	UMYaOLNj1XCbMkLpE/V1x8vCOdKkgr4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ZM5dJ6vRPkahah9K1cSAaw-1; Mon, 04 Dec 2023 09:06:31 -0500
X-MC-Unique: ZM5dJ6vRPkahah9K1cSAaw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c680110ea9so1504756a12.2
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2023 06:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698790; x=1702303590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNqp4EkEe81Xfk/Vi7+bb20ViDEuio2OHUZ3fwYJ9cM=;
        b=G9sdkVyT+hdMvav13YKiAiX40AH7NBp6qrA4h4M72Svyz7jHQ5tiLBcLTz2gb8bcVs
         h8aDVlhqqDXyVR5sBRm9aK9dkekspTdLtD/giG1vzYpxNEz0iAblqUYpE/KhOaPOSUuO
         p/sxo/8tQilcbdAbouk93NeNCyrBWd5f5c/mC3o1ft+gdMMwrj3nIc3e2dheK0KgW2lu
         wePljGtr1y7gecPv78agxi/xBjg/oJqibhbWuhutFgcMkommx6pv62GvUt6hEIn8wp0t
         kkPwjPNWR/yPNQ5lpLRK0wj1aKWIh38mrDFmlSjlLaHlkh1/2EKAgiGq5+3c+dtZ4ASP
         7QIA==
X-Gm-Message-State: AOJu0YywcybY/ZKtNsfZmWBMTC+zptw7dtuYv7CeOhxSJifRGASbRkEY
	R3uPL4fmGDGfvg/ae/dnRxYU7RS5ec5gq/Y146XzXz1ygcFrmdqCQqMBaXORB5ZbjF9wwb/jMwu
	pt2emIUCLnvGC+2GFTw==
X-Received: by 2002:a17:903:2291:b0:1d0:6ffd:9e11 with SMTP id b17-20020a170903229100b001d06ffd9e11mr5130114plh.99.1701698790696;
        Mon, 04 Dec 2023 06:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE52PA1FBe8A8p3MakRZ4cNmu99dq8hmjxV1hIg+VeiROl2aRmMBABshMiJhpoWbv1Rh1aKDw==
X-Received: by 2002:a17:903:2291:b0:1d0:6ffd:9e11 with SMTP id b17-20020a170903229100b001d06ffd9e11mr5130098plh.99.1701698790412;
        Mon, 04 Dec 2023 06:06:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b001cfbe348ca5sm5119809plb.187.2023.12.04.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:06:30 -0800 (PST)
Date: Mon, 4 Dec 2023 22:06:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/733: use correct kernel commit id
Message-ID: <20231204140627.gzztgrtmcmcemyah@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231204113428.68071-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204113428.68071-1-xuyang2018.jy@fujitsu.com>

On Mon, Dec 04, 2023 at 06:34:28AM -0500, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/generic/733 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index ca4dd519..d88d92a4 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -6,7 +6,7 @@
>  #
>  # Race file reads with a very slow reflink operation to see if the reads
>  # actually complete while the reflink is ongoing.  This is a functionality
> -# test for XFS commit f3ba4762fa56 "xfs: allow read IO and FICLONE to run
> +# test for XFS commit 14a537983b22 "xfs: allow read IO and FICLONE to run
>  # concurrently".
>  #
>  . ./common/preamble
> @@ -26,6 +26,9 @@ _require_test_program "punch-alternating"
>  _require_test_program "t_reflink_read_race"
>  _require_command "$TIMEOUT_PROG" timeout
>  
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 14a537983b22 \
> +        "xfs: allow read IO and FICLONE to run concurrently"
> +

Makes sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -- 
> 2.27.0
> 
> 

