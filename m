Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AF217736
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990795; cv=none; b=tyNfy7pPqTZdeoJBaq6Ss58Ec1Zn9ncRBvDw2l+Ttaj1f47EPXMwFzSJzZ7784Y/uZaiP39DlxrfmFCoxHtN2TVcrODV5jMOhR3LGo+R7sbear0yyF6o3kGgG82zumjwAvQUlawmo+jHRXItwGn+HT4tZi7Me/ENJyc70KzfldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990795; c=relaxed/simple;
	bh=4nT3eL+nqqlKXmzFJdFVnTOdEBe7d+tIOLCTKsUwt94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npF6bpHapjhDmwq5EJTJpbqvWqxDvqBvBxOSMzC6fa0kZsXoUHjTACgxt9H9vaXBJ5JwMNVtsxUjKV/JW63fkP5R4sC6B6Y5Y9whIAMFwBJO2V4Ia8canSr+0a8UhOBuQ3iykAMHzr4p21ebngjwSmiBJI+SG7GvjRGyJpPILK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ91WYlr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ91WYlr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f2676bb21so67712485ad.0
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990793; x=1766595593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JZV4ZTKPnvVOohyqVtnOMKthFN4WCJ75pI/pYQsXF0=;
        b=FQ91WYlrlb3ZNT2Y346nixu0QlqkDboGLvyhaNMUZ8dYVjcO+eA9CSsnPouB3awBFI
         ih/Emu3ORhfKb4Cz9185hKIKT37ySgTcqzLRxCZae46WcNukaR3PiuBY1mBY7HUSTMpz
         wJ669cQUKh5aNIyMPniNwaGCfGkX0hrb2tfRbAlP6w/YlfzWSX0vJtkxntBSTQq2btbL
         XNcLtBIvRujfs81wv2VRkZAIlaNHy5rV6yO5Kw/057FRH1rojLIoVgHNYvnmn1V7gRxh
         fZQppAAVFmtHGmhm563AhC7Wuj/cgutgNiYvdSg3B4T6j4o2pH8rJ3jSs0RJszSjcb45
         DryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990793; x=1766595593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JZV4ZTKPnvVOohyqVtnOMKthFN4WCJ75pI/pYQsXF0=;
        b=O96TO9H/W4Uj3G9WYpdk6gK7faoyeKwt+7j7dc8+Wve3lDj8VZUtaYwv3fzR9uzYzS
         wh8uZNz56VIy4jAGJNzkBr0e4pymKdX2b3A+10EBcSN02XlOGWeTZkHew+fuwSFr6toP
         ktyT1Vahqip9uu2Cw/05bn4qYbHKonlde8ahPQOGKbtwjBGMgoHnU85/ZGzi6pJpLxyj
         KmSC8V3VRNdmKau1H6dZEEhjUP9GejgZf0GWxiYrs9DxNIkR7ZC0bDXdlhIrTyHqEDqi
         wxDCmqUZYLR1vS9pTdmvG4GydvS7i2ms/MCV8ynlzLKPnNv4dDtbgbb8gzGjAPj9my0O
         HDgw==
X-Forwarded-Encrypted: i=1; AJvYcCWz5OKzPEMdFS/rBNy4aiiOI5hiqofnQUz+Sxzot8LODDOIodZc5YxIejH8badXLAl1S/Ls5ZFF@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG5642M6LXVwUEJ16zZMRG/3SK1zFwtdOD1mNKme2hwv7+mW6
	lAT3b/b8Xt6dve+cUzWPNdPPw7fGNorz1OklkuNUFXI6vSEjepuCknZ+FyRGnqgZ
X-Gm-Gg: AY/fxX7tn828iq7Eu+P3HnGjPDUpavogRzy59QmA3WTrrLeh407Eguin46XxY6EfrUX
	dEEn7LP128FcQzpcRd6hZtb1yBxYEsvCMkH5RZz1xz9WJHKF+VYe4YjPC+cbL/7El0iDb7eGMm5
	J7IKHZDxjevka6CHjsPxStCAVXQ2ocf7jMk8XYqEXUYtbcZVk/EDOD8bPLgLeYYmbOLI/zTQ9aM
	rTYagxDVM3u632ICszo1aRmTHh+DdYKNqu3H+odBCnEdgA+tLzVlblDQODSTEzAsFOEvF+7c6Q5
	UERscGGfXVQoQ51Woo1psqFBRFzk+O4GFYGnccF6bqpmd7QY4jMNNgMvYEYWN/mXh9Wk8L3GSx4
	kKzMnoJVrpPu+QOPQEf0xZG7Zicf1rYoEO9NksTT8p9aM4nsDJfF0p89LBc81iGpLXB50m7886f
	BiKLn3G8N+cwRryYg=
X-Google-Smtp-Source: AGHT+IFoKMbJ9xsJocF+/SOztzH9OTtMgNQkpOw51+pBJHLXYHTp4rBAb77rmGPybXMBIEZgWFijkA==
X-Received: by 2002:a17:903:458d:b0:29f:135c:5f25 with SMTP id d9443c01a7336-29f23de670cmr175716925ad.4.1765990793498;
        Wed, 17 Dec 2025 08:59:53 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2ccdc62f6sm107615ad.29.2025.12.17.08.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 08:59:53 -0800 (PST)
Message-ID: <62945fac-eab8-4e42-8f3b-dfdee66a1b15@gmail.com>
Date: Thu, 18 Dec 2025 00:59:50 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-2-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


 > where to create the custome dm table.

typo
s/custome/custom/


>   _cleanup_flakey()
>   {
>   	# If dmsetup load fails then we need to make sure to do resume here
>   	# otherwise the umount will hang
>   	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
>   	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null


> -	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
> +	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume flakey-test > /dev/null 2>&1

flakey-test target? Appears to be a typo for $FLAKEY_NAME;
I'll send a separate patch fixing the existing bug.

The rest looks good.

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks.
