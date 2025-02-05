Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E956173
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714146; cv=none; b=HUcQU5S2ai7DR7GhFqSvHrMMvb1H9rmEG0n3v8BYZR3Z1HbntpAUD7yghDc7G74G0TWxc7P5Vl1Ui5qP7yIA5dG6cxxVABQHA3XpMLqddFd7tWXnx2TRAuWCoJif7B+4K64OwlTPC0oVwBc1uUIloJSTlGW0y49XA7LfSI/zbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714146; c=relaxed/simple;
	bh=DlxSGXZU0DWaOR8mpKXyWlkBQrLiAdDhmztPP7zY+KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYvh5zP/1BIcjhWTJfblVd7wSxOcnnwGwW/hSm1XVqIKQLcqUfpKdyBoiUJwVMj1WZ5BYAeTUvfSQjnNqB4sp3Fu0QWDr+y7W7pIZruotXWAzv46iMY4UsJZpQhp8+DFLwkETLN7DrAzoZff/dom3xDl9ltwHbRyBzLY3imsrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=07drgkKR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="07drgkKR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f0c4275a1so15761295ad.2
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738714144; x=1739318944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYQa5iksrp/AjhZ2SgU2sWhfZ2J+sJFerGxdTl91K2I=;
        b=07drgkKRqRC0YwUrGkh+DJz6rC3qB6Y9xoPBvXvO70sMgvwuaC7+hNWeJOoSn5m99g
         3nR0g6kYyTmdtqgihj/ri7Di5v2D2BnEFR4YPnxCRR1dfNS6iOnWJ8I1NrzPAKPcmNEF
         8ffmKFO1xn5hQzAmr8zwuTCDP4L6HHP+3os6q9oK8bEwSYgOMBevWPrdLrlEU3q0IN3p
         79BwTAfxXJGKm+3qV5C1YyzTIBexElcmVWQfRkZDbAp+hMlpuPPoz/xK3NlFNgu7O3Xr
         PwIZFD/HoU+hROgAuEPzcUm+hEivel4CR7ez8BwnrDJiu2mWhnpG5ooc3ToHmlfpSKv6
         +o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714144; x=1739318944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYQa5iksrp/AjhZ2SgU2sWhfZ2J+sJFerGxdTl91K2I=;
        b=nyaIoJl0eRFxc8bpafz8u8cr1nAvsXjdM7sM2gI7+/KFIjfrdyWQQlph379oHB6pkw
         uCyNOfL1rlRJpPz0EYSlcp3vtQ264SYr5tgLfiWtN5rOEdF8cWPpCQWFiHryXYeCvphP
         Ke5lXI/SfNr2o45Fqw7L29634hXyDg4Aacxh7TgVEmBcP1h4nY4s/i7ZGnoSanWbsiQf
         lvFUM0dYO48h/ZMe3YnUfQCEk+5D0sDUsfPoeC2feLkvecv0vrTYLfvKhAcvIu9AGkSt
         84MpH8/uI6QQuIsAjA85adZY7F2HAGCyDWZH4OLG6kvWjQrFqHN5qem/f+G0d18mLJXF
         Prsw==
X-Forwarded-Encrypted: i=1; AJvYcCV3WpH784fqwBcqcu6d8UNJpzmTvrJleVvE1qOYeuHZFXhSSf7E2u0DUazhbX9ZTuicDrpEOCwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2v9L6gpOdfdx1G9iXPKyXgX5VdIM4Zc9yH/kv8QzA7E7C4JyL
	YKnj7zEqLlvtaST/q3LohL+LNjCSqfd+xgwq6NNC7An3WBvPbnq+ZZg9QYY0ztQ=
X-Gm-Gg: ASbGnctiBSERuIwYlt/bC2zObfZhVElnvjKMP6W1LrLwpxP6eJDUiIrKWM5DQ/NlFbT
	kbxDa+EG4FUzvXtThfXjfLn3ir3+cHAtn3ZB2v+gvE8U807ddeiGczZI6GXwBC93HUrkn8nYg61
	LwbQYAx/62PqGm6YVWVXqFMfRWvLEHnZ61IMPH+NNtL0rMSeZnX8iVDnAm8u36VOJQVDGFxGLMm
	Ran9s0pOvE9Ftif/fyLzojhYRNXn7E8V1zRMQaoCCxrIouHRH8h0rfXMzCeut0YyJ6aBewkDWPx
	Rlp2IFCBQvV+hjm7tRFTdTTfvEBt4+i54xGOeFwqj6CRtQ1uidJnxZ0c
X-Google-Smtp-Source: AGHT+IF1nTgQm/3zR702eOCluilvUQRBDi7woD+dIuPFWUp5+iYLkJaePkAZZsHIqqwx/+84D+IQPg==
X-Received: by 2002:a05:6a00:114a:b0:725:e057:c3de with SMTP id d2e1a72fcca58-7303521441cmr1328278b3a.23.1738714144338;
        Tue, 04 Feb 2025 16:09:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653fa85sm10975781b3a.77.2025.02.04.16.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:09:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfSyT-0000000Eilg-38Kc;
	Wed, 05 Feb 2025 11:09:01 +1100
Date: Wed, 5 Feb 2025 11:09:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/34] common/dump: don't replace pids arbitrarily
Message-ID: <Z6KsHTzj1meFDVAF@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406214.546134.16846124942782280576.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406214.546134.16846124942782280576.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:24:07PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In the next patch we'll run tests in a pid namespace, which means that
> the test process will have a very low pid.  This low pid situation
> causes problems with the dump tests because they unconditionally replace
> it with the word "PID", which causes unnecessary test failures.
> 
> Initially I was going to fix it by bracketing the regexp with a
> whitespace/punctuation/eol/sol detector, but then I decided to remove it
> see how many sheep came barreling through.  None did, so I removed it
> entirely.  The commit adding it (linked below) was not insightful at
> all.
> 
> Fixes: 19beb54c96e363 ("Extra filtering as part of IRIX/Linux xfstests reconciliation for dump.")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/dump |    1 -
>  1 file changed, 1 deletion(-)
> 
> 
> diff --git a/common/dump b/common/dump
> index 3761c16100d808..6dcd6250c33147 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -907,7 +907,6 @@ _dir_filter()
>      -e "s#$SCRATCH_MNT#SCRATCH_MNT#g"       \
>      -e "s#$dump_sdir#DUMP_SUBDIR#g"   \
>      -e "s#$restore_sdir#RESTORE_SUBDIR#g" \
> -    -e "s#$$#PID#g" \
>      -e "/Only in SCRATCH_MNT: .use_space/d" \
>      -e "s#$RESULT_DIR/##g" \

Looks fine, if it causes problems further down the line then we can
implement a better filter.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
