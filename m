Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771B18754D
	for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610095; cv=none; b=Pfwu5iONa3BzX6H+oXYNCtpO/28KXDUwxtUYOgppxjsSnOO7/JvVUaWO35RMx5+HTxGX7/53JFJ1LRXY7l63h+H/dIGXc9zTtSDpd6ZZUSwQBFH50Tp8rlb7tYf0o685mBiisJK/RcgYbX0RhBzXHcmGZ8xMsiQP8KMp7T02+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610095; c=relaxed/simple;
	bh=2WqRCQN/Gc5PTUFO2ytJm4eCG9Y+V+l0zuLlL6XqDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft5xjAkVEjmyK33s30JM1EfOaRA+hAfCpfrT+q7bPNrzy1LQmORr2S0thLDkRTOU8QcY7Yuu9JYGnAhbNPO4a5pUke5aPX4EaZgAk8n8+eFfi5zDQtg+34U7OFum0JqowTrW+7A89ku/S+NmrzBv4LasOqw7SYHdxP+xckPbFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuYhGxPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuYhGxPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718610091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+BPazPVGCsIYs0Q0ovpES0Nh8yo2XXdqlMfHBTnRxig=;
	b=DuYhGxPetzlZGAklYOIaZm5lyrweWAFLPE6awStYveZ6Byi8QpRx9VdCFd227C3siyfqwg
	ruMWiH/fTwAZcLI1mPDXmDR7oaejg81FvpMPe89APnjLSNBW07O87ZceAvL4pGbMOXOBxc
	rYjcwxTXfmTGDF+SLSSDD19jsc7Jifk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-qJh-Hk0-N96Xf5QmyhX65Q-1; Mon, 17 Jun 2024 03:41:30 -0400
X-MC-Unique: qJh-Hk0-N96Xf5QmyhX65Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7060136ed89so1056644b3a.3
        for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 00:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610089; x=1719214889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BPazPVGCsIYs0Q0ovpES0Nh8yo2XXdqlMfHBTnRxig=;
        b=Y7iN9ISgymaKQFMbKNxAeSaeZtCa0Dn3GrnV1borZd2qS9gnf3lphp6VxWKLR0lViT
         fvHpeQUTwrPzjgeIgkM/DC78sLq+XZ3qh5Dlo8eO6hr4bqsGNjOqksmUkel6mrQ6+Vvm
         22fZHsj76C71MXQM6DxDqiw12FAJTNUH2x4hHeEc3EvNAJA4YQPcw/MneqYoWokUS2hy
         pJIRmenpoGnIQdne52hmud0j9Bcq8VDoW/V+WNf8XDD8hkVgUAu3mZDqPkGk1gXpiYa7
         qhPpe7PEVdAiPr0lr3dOjqZLDW50YLEZCFiQWjgWNiRykUXfGZ1M1tH1K5HSP+w15QSH
         +5/Q==
X-Gm-Message-State: AOJu0Yw3I2KL6CqXb09NH+fzO+XkBF+zZvwiLTYPGTtlDqvcohZYpch+
	qyKaW5uslUgdYJeMLSMnWTGsO6zK7h59lbN4zJKcdQmr8NOcewyyKf/BaxuPUhM+dH6hFHnDCXp
	EJ+62JAzCVqurNpyQ9T2w/7Y6ndTrZJTBVZDm+xICa8TRjTfcPtetihYGuGybf+uFTg==
X-Received: by 2002:aa7:9e87:0:b0:705:983e:fc15 with SMTP id d2e1a72fcca58-705d71470d0mr9296314b3a.10.1718610088879;
        Mon, 17 Jun 2024 00:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjM8HZqFRuTmafu618e9tift1yGxZWkqct9b/Z9lojHsbb5Ic7W27gjG5VV4UXZJa62n52+Q==
X-Received: by 2002:aa7:9e87:0:b0:705:983e:fc15 with SMTP id d2e1a72fcca58-705d71470d0mr9296300b3a.10.1718610088301;
        Mon, 17 Jun 2024 00:41:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3bf00sm6878063b3a.135.2024.06.17.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:41:28 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:41:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH -v2 2/2] generic/455: skip the test if the file system
 doesn't support journaling
Message-ID: <20240617074125.ehitiydhlspkuxe5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240611222659.256476-1-tytso@mit.edu>
 <20240611222659.256476-2-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611222659.256476-2-tytso@mit.edu>

On Tue, Jun 11, 2024 at 06:26:59PM -0400, Theodore Ts'o wrote:
> This test uses dm-log-writes to test power fail scenarios, so it won't
> work if the file system doesn't support metadata journaling.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/455 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/455 b/tests/generic/455
> index da803de08..6dce8a659 100755
> --- a/tests/generic/455
> +++ b/tests/generic/455
> @@ -65,6 +65,9 @@ _log_writes_init $DMTHIN_VOL_DEV
>  
>  _log_writes_mkfs >> $seqres.full 2>&1
>  
> +# This test requires metadata journaling since it simulates a power failure
> +_require_metadata_journaling "$LOGWRITES_DMDEV"

Good to me, Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  # Log writes emulates discard support, turn it on for maximum crying.
>  _log_writes_mount -o discard
>  
> -- 
> 2.43.0
> 
> 

