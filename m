Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD922B5AC
	for <fstests@vger.kernel.org>; Sun,  8 Feb 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571625; cv=none; b=Plz7syGw4cInaFjYo4HTW6f0B7ELncmU8owodF1mJYBJkbGdjqP3PO3UcDZse3Rh3alvs2Dr1K+9Z7k3bcTsZ8B6cBjv5owBtL4qiYwlXoiqZ0w8KMU7xwiQSUwZmoF5bzSIwZ/mmXijkqb8LDf5cZjQWZ3NbrTHdzgRtcjf2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571625; c=relaxed/simple;
	bh=66MGyAhUlU9MPo46AY/B7WtZrx+zpp+4gQH46VmdMCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwrvr1tJFGLLeh4Z2b6hmwvMnsmLNdFCYxmMzAP8fVm+K+gY1uG5TJXaPmB0Yo74cwwbTYLvVmyzsyvL7s1FcRYawQmeXJDqQYoTvabBP9G3dmw6ix6t03Fm11LPUpMUqOGCqku1M/TueAOq25O2/ivCjGSB02gkQKU87PPBqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxZ86VjD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mE+dD9sY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxZ86VjD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mE+dD9sY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfG69KkwbfNss4k8EFcF/QNdJFpkrTk7nknMwMnAeHw=;
	b=TxZ86VjD2c2n1hKnaElDUBgIEhwkmjsWIDVGqpTeiihwh3AOlJWK5wAX6OY2GsV8vNn/DH
	D97WCdZKPqrSYCJtwsr0fWZL+lX4nLclqnKD3o71JjXQoSRatl+YxKQQfxquAmbEHeE6nx
	yyIKlmdMZ2m6J7QysGM25jGZ5BbQMS8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-pYMD_-iiMfuWP6B5MC8kRw-1; Sun, 08 Feb 2026 12:27:03 -0500
X-MC-Unique: pYMD_-iiMfuWP6B5MC8kRw-1
X-Mimecast-MFC-AGG-ID: pYMD_-iiMfuWP6B5MC8kRw_1770571622
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso1270035a12.0
        for <fstests@vger.kernel.org>; Sun, 08 Feb 2026 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770571622; x=1771176422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfG69KkwbfNss4k8EFcF/QNdJFpkrTk7nknMwMnAeHw=;
        b=mE+dD9sYDWvDvPsV8rJJ9bSszA0WB7dOwbwTytqZ1sVVlKCvEUybcFGXGV/g8esd+z
         mm+S7wwiYrbW1jFFpChm/ldtFhwlltGXjvqeyOii2ebF39ZOj5z3Yg9UF2zvpK62TVHX
         uA1DtyU95UcomFRhopYNjaLIC4oKRjV+3wA6Nc0JXy2HU1grA4S8deZqrWFrMbPiW10B
         yS6ArXnMRJv5RwbZ6XvMQ9Vqw8HGqAJI6PSxi9nguys/ycXaZ+aFFlzCShSodogfXsO4
         qeovqX347aG3VR2z/QR1xSH5V3jgdEORp/wZwRYZDJCz881bDy7n/owIW6d1SDEQ+HK5
         JaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571622; x=1771176422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfG69KkwbfNss4k8EFcF/QNdJFpkrTk7nknMwMnAeHw=;
        b=LBa4TH5FRQDHgwHCZjBz0kJcM4cN06vz3Mb815XM+R5EAeu8pzeGH6l1lsYfXvQyGG
         wKjsmTJW9Ar3Ns/N4wsJRhhXyBUNPm6cgPwtpWZQY+0dcAl5AHpCFWOsDFh8cnr4iiba
         eb6mf4bxRuFWQgIDP336lzjY0BH3GQOLyxMcOD17D5yWmQyWaRDZeokzqgscr9tacfRO
         Ch7oJ/Hw93kSmoJmtc+QWdxDJRac5MbVAa+R9CEQW7iXDCbXeMfd7ejFVVerh3OIkkPf
         tgF6DFqJBFaBedu2ShB6ThR+hdNVI/nO0I9earSqhm1uT67t30yFc9KZdNY7f5IzL9am
         z6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn4qfe8BXWKjth5JQMlF2+fdqCRwZU8lW8zmoCdt7vqxOC5p0NK0nuTJ6vIOujG7t8/7vk2b55@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2QK3Y9m/ygQPL9WpOGTAEXtigZbUeE3xRLHomknDPmKadIKS
	qsjqK8IfazC1tzg3XMlXIBcm2g7XzkgrINh1AmBxiwQW2vOv6RblmxYv2e6epz/Ldxt1mmi2fh7
	k2OvQPI+LftjCKbS22uL0zRarnM+xHHpA4i8NfTFYs5SqCCHIUU9MXwqo+6M=
X-Gm-Gg: AZuq6aKJE/BBdOSPzzh6srI9UL6lMO0DiGiU7kt8pNTPcOjBkP+HrsXFk9La/eJ7uRU
	GYuz4nfE1u9bgdaziIIJX5TB8YQtA1oNdHAFvswYfcgqb71ZhbuxTMiErVGhrgSDubuQE2ZOrMW
	yuWKo12mX0qgFIs26mg6dDHf3cE3S6ssX4oLhiGHLs6A04Pf93pC2ehVlVJE8LR8kIQN1oo9zlU
	nx4R3cINVJj3qVS7vjWtiB536rp9RMH+NXdNMhOvEf3V0stQ/GkuAfiniwQfqD8JU3BHHpsDxTs
	L9TuYpIl+BBwrkXJSw93H90HNYKW77wdY0VqKZeSoxjf6GWa51mFrMJQat+0XRkGFgN+BhSZFJi
	Pi74bD59GQYLb+XeU2OmljmnLYmXKe2SmAYyVbuOqr1U1Y5l2jw==
X-Received: by 2002:a05:6a21:7a8b:b0:35d:1bcd:6882 with SMTP id adf61e73a8af0-393acfe82d8mr7048428637.23.1770571621999;
        Sun, 08 Feb 2026 09:27:01 -0800 (PST)
X-Received: by 2002:a05:6a21:7a8b:b0:35d:1bcd:6882 with SMTP id adf61e73a8af0-393acfe82d8mr7048422637.23.1770571621527;
        Sun, 08 Feb 2026 09:27:01 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb4fb808sm7753079a12.6.2026.02.08.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:27:01 -0800 (PST)
Date: Mon, 9 Feb 2026 01:26:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1.1 1/3] xfs/018: remove inline xattr recovery tests
Message-ID: <20260208172657.2dq3esy44c7p7vnb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
 <177005945298.2432878.17951687824065765554.stgit@frogsfrogsfrogs>
 <20260206215400.GC7703@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206215400.GC7703@frogsfrogsfrogs>

On Fri, Feb 06, 2026 at 01:54:00PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In Linux 7.0 we've changed the extended attribute update code to try to
> take a shortcut for performance reasons.  Before walking through the
> attr intent state machine (slow), the update will check to see if the
> attr structure is in short format and will stay in that format after the
> change.  If so, then the incore inode can be updated and logged, and
> the update is complete (fast) in a single transaction.
> 
> (Obviously, for complex attr structures or large changes we still walk
> through the intent machinery.)
> 
> However, xfs/018 tests the behavior of the "larp" error injector, which
> only triggers from inside the attr intent state machine.  Therefore, the
> short format tests don't actually trip the injector.  It makes no sense
> to add a new larp injection callsite for the shortcut because either the
> single transaction gets written to disk or it doesn't.
> 
> The golden output no longer matches because the attr update doesn't
> return EIO and shut down the filesystem due to the larp injection.

Oh, that really makes sense to me now, thanks for this detailed explanation.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v1.1: improve commit message, add rvb
> ---
>  tests/xfs/018     |   24 ------------------------
>  tests/xfs/018.out |   45 ---------------------------------------------
>  2 files changed, 69 deletions(-)
> 
> diff --git a/tests/xfs/018 b/tests/xfs/018
> index 8b6a3e1c508045..9b69c9cb14b33d 100755
> --- a/tests/xfs/018
> +++ b/tests/xfs/018
> @@ -127,16 +127,6 @@ mkdir $testdir
>  
>  require_larp
>  
> -# empty, inline
> -create_test_file empty_file1 0
> -test_attr_replay empty_file1 "attr_name" $attr64 "s" "larp"
> -test_attr_replay empty_file1 "attr_name" $attr64 "r" "larp"
> -
> -# empty, inline with an unaligned value
> -create_test_file empty_fileX 0
> -test_attr_replay empty_fileX "attr_nameX" $attr17 "s" "larp"
> -test_attr_replay empty_fileX "attr_nameX" $attr17 "r" "larp"
> -
>  # empty, internal
>  create_test_file empty_file2 0
>  test_attr_replay empty_file2 "attr_name" $attr1k "s" "larp"
> @@ -152,16 +142,6 @@ create_test_file empty_fileY 0
>  test_attr_replay empty_fileY "attr_name" $attr32l "s" "larp"
>  test_attr_replay empty_fileY "attr_name" $attr32l "r" "larp"
>  
> -# inline, inline
> -create_test_file inline_file1 1 $attr16
> -test_attr_replay inline_file1 "attr_name2" $attr64 "s" "larp"
> -test_attr_replay inline_file1 "attr_name2" $attr64 "r" "larp"
> -
> -# inline, internal
> -create_test_file inline_file2 1 $attr16
> -test_attr_replay inline_file2 "attr_name2" $attr1k "s" "larp"
> -test_attr_replay inline_file2 "attr_name2" $attr1k "r" "larp"
> -
>  # inline, remote
>  create_test_file inline_file3 1 $attr16
>  test_attr_replay inline_file3 "attr_name2" $attr64k "s" "larp"
> @@ -195,10 +175,6 @@ create_test_file remote_file2 1 $attr64k
>  test_attr_replay remote_file2 "attr_name2" $attr64k "s" "larp"
>  test_attr_replay remote_file2 "attr_name2" $attr64k "r" "larp"
>  
> -# replace shortform with different value
> -create_test_file sf_file 2 $attr64
> -test_attr_replay sf_file "attr_name2" $attr16 "s" "larp"
> -
>  # replace leaf with different value
>  create_test_file leaf_file 3 $attr1k
>  test_attr_replay leaf_file "attr_name2" $attr256 "s" "larp"
> diff --git a/tests/xfs/018.out b/tests/xfs/018.out
> index ad8fd5266f06d0..be1d6422af65a5 100644
> --- a/tests/xfs/018.out
> +++ b/tests/xfs/018.out
> @@ -1,26 +1,6 @@
>  QA output created by 018
>  *** mkfs
>  *** mount FS
> -attr_set: Input/output error
> -Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file1
> -touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
> -attr_name: e889d82dd111d6315d7b1edce2b1b30f  -
> -
> -attr_remove: Input/output error
> -Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_file1
> -touch: cannot touch 'SCRATCH_MNT/testdir/empty_file1': Input/output error
> -attr_name: d41d8cd98f00b204e9800998ecf8427e  -
> -
> -attr_set: Input/output error
> -Could not set "attr_nameX" for SCRATCH_MNT/testdir/empty_fileX
> -touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileX': Input/output error
> -attr_nameX: cb72c43fb97dd3cb4ac6ad2d9bd365e1  -
> -
> -attr_remove: Input/output error
> -Could not remove "attr_nameX" for SCRATCH_MNT/testdir/empty_fileX
> -touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileX': Input/output error
> -attr_nameX: d41d8cd98f00b204e9800998ecf8427e  -
> -
>  attr_set: Input/output error
>  Could not set "attr_name" for SCRATCH_MNT/testdir/empty_file2
>  touch: cannot touch 'SCRATCH_MNT/testdir/empty_file2': Input/output error
> @@ -51,26 +31,6 @@ Could not remove "attr_name" for SCRATCH_MNT/testdir/empty_fileY
>  touch: cannot touch 'SCRATCH_MNT/testdir/empty_fileY': Input/output error
>  attr_name: d41d8cd98f00b204e9800998ecf8427e  -
>  
> -attr_set: Input/output error
> -Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file1
> -touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
> -attr_name2: e889d82dd111d6315d7b1edce2b1b30f  -
> -
> -attr_remove: Input/output error
> -Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file1
> -touch: cannot touch 'SCRATCH_MNT/testdir/inline_file1': Input/output error
> -attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
> -
> -attr_set: Input/output error
> -Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file2
> -touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
> -attr_name2: 4198214ee02e6ad7ac39559cd3e70070  -
> -
> -attr_remove: Input/output error
> -Could not remove "attr_name2" for SCRATCH_MNT/testdir/inline_file2
> -touch: cannot touch 'SCRATCH_MNT/testdir/inline_file2': Input/output error
> -attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
> -
>  attr_set: Input/output error
>  Could not set "attr_name2" for SCRATCH_MNT/testdir/inline_file3
>  touch: cannot touch 'SCRATCH_MNT/testdir/inline_file3': Input/output error
> @@ -131,11 +91,6 @@ Could not remove "attr_name2" for SCRATCH_MNT/testdir/remote_file2
>  touch: cannot touch 'SCRATCH_MNT/testdir/remote_file2': Input/output error
>  attr_name2: d41d8cd98f00b204e9800998ecf8427e  -
>  
> -attr_set: Input/output error
> -Could not set "attr_name2" for SCRATCH_MNT/testdir/sf_file
> -touch: cannot touch 'SCRATCH_MNT/testdir/sf_file': Input/output error
> -attr_name2: e43df9b5a46b755ea8f1b4dd08265544  -
> -
>  attr_set: Input/output error
>  Could not set "attr_name2" for SCRATCH_MNT/testdir/leaf_file
>  touch: cannot touch 'SCRATCH_MNT/testdir/leaf_file': Input/output error
> 

