Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqQiXE+f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE548193
	for <fstests@vger.kernel.org>; Fri,  8 Dec 2023 20:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702096880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3mWHZcXaAmj/5u7LgLw6LKkZfHWgV29XQk0gJ0hZWpY=;
	b=VqQiXE+fToQNQl67rB6KED4/wYiH/FYAaJQPotSkhra8fsitFH6B/BVk7COhUzei6NbnVl
	05RcyLCee8BKPtbUupJL7u2Nm+0/5Ke0pl919zyN1EIDm0pkcfs3weEskVNTHi/VmOJvqG
	elej2dvzk34uVl+1qkHdKyjYPgLr+9s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-p9piWH2rNwuMQAlP1Few_A-1; Fri, 08 Dec 2023 23:41:19 -0500
X-MC-Unique: p9piWH2rNwuMQAlP1Few_A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c641d55e27so1770458a12.1
        for <fstests@vger.kernel.org>; Fri, 08 Dec 2023 20:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702096878; x=1702701678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mWHZcXaAmj/5u7LgLw6LKkZfHWgV29XQk0gJ0hZWpY=;
        b=meLAlmnT+0rfqlGM2M3dczncQyFJdYcRIHVglUgUielxJE4b14pi/i7pNvYI74MEKu
         +TPh6ObZ8PqvxLB6AVqj28WwKvyOs1rFPR9bBBZ8S5eYygnx4tMbUTBsGfGOZ6N610+b
         e5CLp3APn2+Lm8otvihBPlO9U6YRXTc8coC0HA0TGxcR6/JXdlNJy7acgVm5ogWmwVhM
         Uc8SfuT4kBKSWvO+hLCq5JpJT8USODM9iBNWJ2Ii/q2KoeGrP7XDOCxBRzoZzjaOadMc
         zz1IeY3/RsSl+tkbGvgdrmeOjjVOiRD3WGuCFAOMB5Kdc+LTr0ehCIYBKQbqk2wvhx/e
         OxMQ==
X-Gm-Message-State: AOJu0YzXoMpskiQqee6xbHqkRTz9UfVs5iffHTrmNfNO5s9Li7a2/HRd
	AIVIEAcjCQXgIfICOxhLxBjCXkkcfH3IwSl5xJ6UEq3yk2t16FDY+kvFeYAdO7OoA9mAnZ6L3cH
	qnJ5MGlOsdGF1VCZ8iQ==
X-Received: by 2002:a17:90a:246:b0:286:6cd8:ef18 with SMTP id t6-20020a17090a024600b002866cd8ef18mr2075179pje.48.1702096878410;
        Fri, 08 Dec 2023 20:41:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUDHO38yZH4Tnbskvnqzmjd3UyZ0cZQXqt8FyXBuY33QNAIZnR9Duur8L535btVrIc5l2h0Q==
X-Received: by 2002:a17:90a:246:b0:286:6cd8:ef18 with SMTP id t6-20020a17090a024600b002866cd8ef18mr2075171pje.48.1702096878047;
        Fri, 08 Dec 2023 20:41:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bv190-20020a632ec7000000b005c2967852c5sm2363820pgb.30.2023.12.08.20.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 20:41:17 -0800 (PST)
Date: Sat, 9 Dec 2023 12:41:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/303: add git commit ID to _fixed_by_kernel_commit
Message-ID: <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>

On Wed, Dec 06, 2023 at 10:24:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The kernel patch for this test was merged into 6.7-rc4, so replace the
> "xxxxxxxxxxxx" stub with the commit id.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/303 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> index b9d6c61d..521d49d0 100755
> --- a/tests/btrfs/303
> +++ b/tests/btrfs/303
> @@ -15,7 +15,7 @@ _begin_fstest auto quick snapshot subvol qgroup
>  _supported_fs btrfs
>  _require_scratch
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 8049ba5d0a28 \
>  	"btrfs: do not abort transaction if there is already an existing qgroup"
>  
>  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> -- 
> 2.40.1
> 
> 

