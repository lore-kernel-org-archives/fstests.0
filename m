Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05271EAE7
	for <fstests@vger.kernel.org>; Mon,  5 May 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439097; cv=none; b=B+OMfR1emasjew+2i2E+6wlMqjR6ZunwKlQVYs1JiCf7uY5a9eswfDmsUqbSggVR7OU2LSDxvQlQ2ckkJ4BQMFLxriKKQzdxZtPX17p/oSI0NO6ixuU23HSzwfuW8fSIJYkQtinKwlPlkPo5slTMu8MOSiDU2BwMvifu4X0HZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439097; c=relaxed/simple;
	bh=DVB/gS8aBQLGSjtUP0/kUGKLjZkWFmTbNSDnX7uUlGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Ji+vj7Q4335Pz2NqL2SxkHfq1hzqjMkhq7nwrmc0TX6P61DrMME5iGMk/JVQiqB1tNOs04LBica9VCUA9HdNS9blioNco1RZAmszKn6DSDeSnl4wJ3hXQ23rFh3AueMkhRvoBl82nGeRYAF4tAq3BAJVJU0yxai2o9kqmgtUYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaQow1l+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaQow1l+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1f7f239b31so4304026a12.0
        for <fstests@vger.kernel.org>; Mon, 05 May 2025 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746439095; x=1747043895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9n5Rf66acid9YKcDwXVGP9PuTDgq9HYeTl8UD1gfeg=;
        b=MaQow1l+TLkJ7NgEk/rfzcCy3lEs5/3fR5tJndrwmol8yb0TrNIB9CwCS91Wg2OMhY
         tcjeIxKVtGtA/16eZ0x9c0fMvN22/mxzl0h1S3gPuoNo9sraFO76+MlPmfH7ywJw1lLu
         balqCs+8HvhbD8V023ld1XBa00EZStAKV3Ur8SAuxLxi+xH6cdUPBA/DG9bM3YCbwllN
         xq99oeglNaxJ1jFTjdCDzoLIDgl10yevppkBOFHRWoGd893wruoL/Sj0XQ1w4tj5qnms
         SfNOrpKlnKY0Uclzriitu9JGYqnDwVOnwC/OueQMcwQ+/u/I62yraYfnagly/RnwTrHc
         SNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439095; x=1747043895;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M9n5Rf66acid9YKcDwXVGP9PuTDgq9HYeTl8UD1gfeg=;
        b=TyEqnrWSLO9ctOpj9YNmML9ACyhOgWRjTKxdXBeUTl8EHKNRo4QlAFiHPYaNeT+awI
         mvlHHn/OIjbhiN3xfegRFV4n3kf3apI2DFSvRcn6ZT6q9G5JnG7Ccw46RJvLvzE2P0+T
         nsy0QYS9fLTx4KD/p+yFKEVQNCZv5FcIEnBKg2+AejkmvEAZavJeSLECPvnrSCbHrNXI
         OYzl8RHgKtkePxgyj5/1hKiZdeqUtDRajP7lPJ0F9be3cMY3/PjBPjICKnkTlaeUqqZg
         4L346KmgbmKQE4hMesQ6yvoAQiqlO7GK55mYX9AdvAD2oM1gs4xO7RFV3pphsUgFqoAj
         eFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWWuaSEJ2W1muLpGrvX+P9loeNa1bJP2wmQodrhjuf3UvwAFBtDcqA+KXW0IfgCbUhchfjvIoei@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYcb8wqT6wwXBbkKEUfcUE/dtAf+QOqF9bq3yJAX7zFCn3X8R
	Zy2qgTQZwp/DOkRteh4FBwkcJc0qGlp/ErDQ1IzjtR6EnXvvw1F4ZF+1OA==
X-Gm-Gg: ASbGncuh0czDa3qqTHRHObL6reygzWjZTNCmrVR6jrALznPHpIgBEAUkUCC2lm9xDs0
	YzBGKBdoVbvsIadCLWbYnee0zf4O7jRK/HrKFc9KvQAYkfKE3aMUYISW31UCDFT+VinLuw38Yk0
	JVcmxxp4Xv1mLjjsJbHvN8ZJqq0KX/gfatzdbN8fyVqiO3eIGiJY885Hf44PeV5oiF7gGoX+gCP
	dydRM6EGShoF06wWfxjZUNa/dQXCthcOFZXSrryM8y/nCqnH76Gq1KDZzIUYE34/lwoE6n+vakT
	q/OXpUqsz08JCLJta1ef0ELXHu5y4ujKbcHTDA6RvI4Q8QOvqxdVgch6ngjNsomy4JmYmJXagLy
	KEPPyk+vKjQTljnw=
X-Google-Smtp-Source: AGHT+IHymhYGmbJIFDYTyeEoiAPb2voQYDBpjxO856uKBRgIeMOfgsnVau5+uMzqkYGUwVdyejUZSQ==
X-Received: by 2002:a17:90b:5242:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-30a42e73ab8mr23218515a91.8.1746439095030;
        Mon, 05 May 2025 02:58:15 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm50197855ad.179.2025.05.05.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:58:14 -0700 (PDT)
Message-ID: <a6b7ba3c519e9db3f408b913dc18fc732cde1241.camel@gmail.com>
Subject: Re: [PATCH 04/28] check-parallel: report how many tests were _notrun
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Mon, 05 May 2025 15:28:10 +0530
In-Reply-To: <20250417031208.1852171-5-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-5-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We already count tests "run" and tests that failed, but there is no
> indication of how many tests were _notrun. With tests actually
> failing to run because of things like bugs in _scratch_mkfs_sized
> being reported as "_notrun" instead of failing, visibility of
> changing numbers of _notrun tests is needed.
This looks okay to me. 2 questions below. Apart from that, this looks
good to me.

Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/check-parallel b/check-parallel
> index c85437252..d68d76e55 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -188,7 +188,10 @@ done;
>  wait
>  
>  echo -n "Tests run: "
> -grep Ran /mnt/xfs/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> +grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
Nit: /mnt/xfs --> $basedir is not related to this change, right? Should
we move it to a different commit/patch?

Not related to this change - Can we change the above statement to
something like it is done below for _notrun i.e 
grep "Ran $basedir/*/log" | uniq | sed ... | wc - l
in this way we can get rid of the sort command?
--NR

> +
> +echo -n "Tests _notrun: "
> +grep "^Not run" $basedir/*/log | uniq | sed -e 's,^.*:,,' -e 's, ,\n,g' -e 's,^\n,,' | wc -lDon't we need to sort before uniq?
>  
>  echo -n "Failure count: "
>  grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\) \([gx]\),\1\n \2,g" |wc -l

