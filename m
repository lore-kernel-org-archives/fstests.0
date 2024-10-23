Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03B4204E
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656916; cv=none; b=EaqycS/CynNEGt672c6BmX4YQTECbOsXjh5m7sxy+MTT/Ak1BLA2Z5P2r4H6NtJDCzUGLzGZqCGgVG8PgBBq5FwO4MM9fdLjyx36lAHvSRAwAj2lSDP6Y2vqE89a14c9Ku4w6oUsK3VV5y3NHk5QoAJPwxHSULIO7isiZPal7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656916; c=relaxed/simple;
	bh=JmwRdTIskf+AsMMCCxjo94Vnxe2+wbrUwIrR6N/UlE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5Fglro5UXxYNVhNXu6mm5gW8HE4otIjF01sNgOPS5VNAtGkus7SGJdDjhzhPkBNbE5k94ic5XV63n3VqBbeBWdbNy+cbcx2zuXh4xbCol99JNidrxmPaOwbovBirEwTUYjfaUdRm/3R7B64/STxmIkM2tYdnJySo/RhJeEYhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TU89Uvm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU89Uvm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729656912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUoxSHiWDgCVgLsFRPvTqiN+l9Des0mYN1Ckud4gffo=;
	b=TU89Uvm4wF5QnHyotmIluWTzuUqhvwW3C9Ub208McoNReHEdDTX+fPamhPmPDqw+VpwdSL
	XICCSjHB5jsMX7NvbVA2THWttPsHSu+BBB32VlItmS98sZP3mNY3rSS8da227ZFpTqhgxJ
	/DJohz01WabUUXEPAdUFvZtddlkEiKs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-MT5ot_bkMrav-Bcs_kekWg-1; Wed, 23 Oct 2024 00:15:09 -0400
X-MC-Unique: MT5ot_bkMrav-Bcs_kekWg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e5a60d8af1so3332623a91.1
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 21:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729656908; x=1730261708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUoxSHiWDgCVgLsFRPvTqiN+l9Des0mYN1Ckud4gffo=;
        b=NghnHU+nzYjtYQg7WYCY89MLLaeDu2M04vkPzM6deYp8lI74gVBiwp+2HOJGhZHG7o
         kbfy8ZDNDY2jC5keopzliwHvocMrb62TIRkrALwdr+9tSChr34R5X1DlUQ7B0YmiKAfp
         w2+37erFFLxgdET930ylA2HOEFxbJPwYgfgudH2mJ070Kbm9ma0RK2UUT9AA8uhRiqX0
         xcnbbBgt20PwhnQm/Xz8Y45DreTXYlDIh3c7vsM0Da02WC2m2CPfIkjTOrbL8NVHj4Rs
         y2jIgG6YQjZw1JrM9u5DOwNmHBQ+GaUyGrFuOMn+OYx/Fsm/mkNp6JAX58sKH5BNipzs
         EDuw==
X-Forwarded-Encrypted: i=1; AJvYcCWkapNsvqtryfv5VB2evZ0s0lO13nDjxIZB+mZraL+qJCjpD9yjHqP9UCgpPlHxi71xc5ML2cAy@vger.kernel.org
X-Gm-Message-State: AOJu0YzpX13AWao6/BOmiZKErWZfRIg+W0qK9L9/iOFZsJvFSORfhE3f
	D7UNDNjdUxrcCrYvTOyhU0PiUZyeuglJCM8Tp2mYvx36a/GQ52s1eiuhmg0K/oHjZLjVohzzBBO
	OkcAEv50QpgqK6fVv8PjBQGuP1kwqaM0PkIwylm6vlzupXhJvLv7aFN+oWN1cx7GO0w==
X-Received: by 2002:a17:90a:2d82:b0:2e0:8e36:132 with SMTP id 98e67ed59e1d1-2e76b5b57f9mr1417840a91.3.1729656907957;
        Tue, 22 Oct 2024 21:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcZY+Y6w/urBHRr5QoKR+rA/UuvJ7bZl0HtBPi7B5QNkmJB1U5Hi4XPjulwGBXdqnaKriCrQ==
X-Received: by 2002:a17:90a:2d82:b0:2e0:8e36:132 with SMTP id 98e67ed59e1d1-2e76b5b57f9mr1417825a91.3.1729656907626;
        Tue, 22 Oct 2024 21:15:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfeece3sm294579a91.57.2024.10.22.21.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:15:07 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:15:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/xfs: _notrun tests that fail due to block
 size < sector size
Message-ID: <20241023041502.gwnyxvngsmt4rv3b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172912045589.2583984.11028192955246574508.stgit@frogsfrogsfrogs>
 <172912045609.2583984.9245803618825626168.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172912045609.2583984.9245803618825626168.stgit@frogsfrogsfrogs>

On Wed, Oct 16, 2024 at 04:15:16PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> It makes no sense to fail a test that failed to format a filesystem with
> a block size smaller than the sector size since the test preconditions
> are not valid.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Makes sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> 
> diff --git a/common/xfs b/common/xfs
> index 62e3100ee117a7..53d55f9907fbb0 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -172,6 +172,11 @@ _try_scratch_mkfs_xfs()
>  		mkfs_status=$?
>  	fi
>  
> +	if [ $mkfs_status -ne 0 ] && grep -q '^block size [0-9]* cannot be smaller than sector size' "$tmp.mkfserr"; then
> +		errormsg="$(grep '^block size [0-9]* cannot be smaller than sector size' "$tmp.mkfserr" | head -n 1)"
> +		_notrun "_scratch_mkfs_xfs: $errormsg"
> +	fi
> +
>  	# output mkfs stdout and stderr
>  	cat $tmp.mkfsstd
>  	cat $tmp.mkfserr >&2
> 

