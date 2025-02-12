Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C21FF5EB
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394101; cv=none; b=lm9NIM4WNSiJucIZsW+QZUckbLrY2kvu7cRnOnkCTyvDoVBB6pOR1bINVlwKpLEdY2PVOklm6l58EXsO68jVXSPI7y0FlfcWloG384PSHRB6TVmoLXne6kE1gNvVWM1gac4CMQkBPJjbREJmDqzgu9kEKX6EVvhQ5n2BVzEGHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394101; c=relaxed/simple;
	bh=1VyAEiQDS2q9VkRGK+qwT+LU5/8emzrXoHFxIXPyBLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II98ZtLDl04lcu77B+TEgc0CjgnxpJLwv7aNw7+nbRipqcxGYek0bsZbfHW8kENHYi446/W7u77RZeodEqg4bFm4SRTPKQcIg3qjX2BvD7RKAMVnLyVbXlx46xtSL2JfaqNEyZgxsOjO/6HIpdxGp8I5f3qDpeVNRbgYah0swY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dXkaMLAi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dXkaMLAi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bfdfb3f4so2160005ad.2
        for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739394099; x=1739998899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIR6zZ2LFfRJBDmVHzXDNp6ZFUCOkYJZeyqW+eFjzG8=;
        b=dXkaMLAiRFcefsSibZnHaWvEIsJnViDbvC4+W3iGzjZxhcLZT4Cxe9mWzWgjiuzIND
         pTpmDbiquuCq58KfFGME0uGDvFmed2973V033u3wJi/ySi37h5jmL1YUM1z5Rr8i04w2
         wplHBC7pIoG0Lk0bMH6HlqJmMRVPjyQ+Hn6+T/BkLm48GEE9nYa5wDRLEahW8H4BqG9s
         ST/IBhVE2F275QdgOJJStNBhB+ZUrtQPxAfv1NvpXyZdO9tiBrScpH9LaCrXO8NL/B6x
         rJV/69IrpGRA/1aduMAnSxhGQ0R4WQ+dASBSFD4HmwSBAUghZmpnOjHUHMfNxEfIt4ME
         os0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394099; x=1739998899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIR6zZ2LFfRJBDmVHzXDNp6ZFUCOkYJZeyqW+eFjzG8=;
        b=Vj2TqH2D6ZSUPZwm2osuGdNjvNQre+2FY8Zu9fwYA1kTqPNRyH5VJmNuZ028E1EATy
         KL2F+ygphZLL/0xWteOr56JDGcSJdjf38eVSfNMbSmsMbai2xyP6jRbhe1msrgkUC1+K
         HDM+DJ6sgds0lNdpGjTCm17Qy2UVnA+U6uBfa/ViNJqdsdjCKVBnAz8TdJvroJobAO2c
         G//+sXjui3lQ1FBI2ezcSLmyhdJk7+otkaZaAh/NbGL5gMWt72RZAQClIKexoZ6orp27
         xl631008MbWAj/l3gAJyd/taNeuXoy22KxLE2WE2cRFBXW9iXX8VQ2mTM3f496I6lZZu
         yzWQ==
X-Gm-Message-State: AOJu0YyutSImhQGGwPF1FW1x9Sh7LaSX67f76ptLzRymNp1Rmg1Rg+ei
	CIcz00iZylglWNMnuT4Ra5zfcT9CcB4g93MyiBRIri0v8KjgrcmD7EOx6ofXeuKSnqnJhgNvpb1
	D
X-Gm-Gg: ASbGncuIp8BfRnNdFBak9UEhR7m/C9/rIOGUQLb+V8N9zusSIQd7Swa1N8nydO4JZ4G
	cc5F0bkqFTH0cerWh1mtPtGuIF44wWp4mirK/J4HQxCuZvZPkDQtWkACbs+6bwdX2ZY8hvzzbUN
	BMzEHW5kV/z2XyorMy88zGn5DJTW4zJNO4dG2+4+8dPpLptxf2QKpmj0pfQSjNLNKyPlHUYemm/
	qxFHTQg9rEvvdXNvJDKZBSR5hhpV3nMB0RnTte3AoiByJWiJ4CRO1pld+PZYk6e8a+fCwcLm/90
	6tnbvOhV1b5pB02J7FxC23H8iFhbS1FIF8MUJWHm0ukGjcsUc4tLxx/2sBNxSSf+xPk=
X-Google-Smtp-Source: AGHT+IFZQ+UkMOepNiqiOeT5081AklEp/hOZMtQlwn6wyDVLQoiCCEa+ujVvRZhLWXYZgNe74j04vQ==
X-Received: by 2002:a05:6a21:482:b0:1ee:668f:4230 with SMTP id adf61e73a8af0-1ee668f42e9mr5152871637.33.1739394099547;
        Wed, 12 Feb 2025 13:01:39 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad6019204c5sm4418595a12.60.2025.02.12.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:01:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiJrU-00000000RG6-1CPB;
	Thu, 13 Feb 2025 08:01:36 +1100
Date: Thu, 13 Feb 2025 08:01:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 1/3] xfs/539: Skip noattr2 remount option on v5
 filesystems
Message-ID: <Z60MMI3mbC9ou6rC@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:56PM +0000, Nirjhar Roy (IBM) wrote:
> This test is to verify that repeated warnings are not printed
> for default options (attr2, noikeep) and warnings are
> printed for non default options (noattr2, ikeep). Remount
> with noattr2 fails on a v5 filesystem, so skip the mount option.

Why do we care if remount succeeds or fails? That's not what the
test is exercising.

i.e. We are testing to see if the appropriate deprecation warning
for a deprecated mount option has been issued or not, and that
should happen regardless of whether the mount option is valid or not
for the given filesysetm format....

Hence I don't see any reason for changing the test to exclude
noattr2 testing on v5 filesystems...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
