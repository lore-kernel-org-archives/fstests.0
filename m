Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714036;
	b=qPYWKukqeQf3b3/g257P/LEq6zDn7Mnts8zU1GsYL/gvKgcMX9ogFJPlRYdOhVjMw4/e
	 efQledDkVr/C9LOlfzbaQylYT+bkpNiDIhz1/xAl6vbhLs2qbVuhxoCOX+LD5YYC3TiFj
	 ucyw3nfxBHBAxXKakppIjB3MoeUaWEN242nVpdwMzxY13mBpBmVMIomAGfUTk4ijTz9fK
	 RW/0yhU9Muf64+T6ojaHZL7GL0pzclo3i4SsRWfwVpMeiQU9SZdw/RIE0UF7OVOFYISAI
	 IMRJ+NFR+9B1nvmz0UHrUbLm2rRy+xu11f8Z2uy3krFeLZRVFY3e3s+itwZ0i+Htmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:Date:Message-ID:References;
	bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
	b=BG8hkZ8xUoH/WCdwpvO5X3s29hnsdzxnv5EQ4ykYRU1iQpkntK5/ykS+75k8gWdV1V3t
	 mHMQLCTF4ZIMu9tEHTPI89SFoyBIro9Kpkmsfr7S9Z9LSoepBmLkQGlCpTS/XUFpa6084
	 NcrRWsLb4+n3NW8XIIjiLlsABJrhSNEmCYsio/tczhdZyQFu5cjyphmK/1ZPsf1ofOjGm
	 4b7hajZXL+eRbhJodCL22FGriQI2xs7cRSPgRofmp8PC45extK82vxsZPXoPObnB+0SXH
	 iKGWTEq2tgCGrMg2OhA+xwzru+q+gB09vrPCoRmIDBfwpI7lgyl2J3wqEUrtvNji2Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+GGjTur;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B0606A31A
	for <fstests@vger.kernel.org>; Fri, 23 Oct 2026 00:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+GGjTur
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so984902eec.1
        for <fstests@vger.kernel.org>; Thu, 22 Oct 2026 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792714031; x=1793318831; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
        b=m+GGjTurIp4URWCyne0AEstlg/S/hifwoIK3vMGc3ULvXuI2/avQDamAyvbwufeGmM
         d4UTiM6MJMonBPDDNPmFRfHQX//HDuDMtMBQOazdDOj1QtK63quy3MiaQuTpH82vLprv
         vx42K36TjgoJl0Nm6EriCVLzGGvhHcMqXtjwW8oaIhWml1qbU2iKsA0CZx9Kv6qM0RT0
         AYFmvn18BC+UfLUm1pzPYGE1a3fqz2ItID5ZRGn0AWKjkP1pcGUfgbfNkzl5tf5xh0pD
         B0X6oCzteP7JrqmNHvJ0dpyaA1YvhgOmNqRL0LfSiKZ43JNbXrFuQsFque5GTTO0G3yC
         t2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714031; x=1793318831;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
        b=0fs/uqm9XFM1Jh+Z2TYZXMwEYZCfVWO9E4xTyoAPLmpKeLulTYs8iNG/rS3EFgoK9L
         rrQiHzHb0n0f4EJBMW8yBCqWjxpebIvciYxmiNAu9zpilDFRxahC1Ewx0rl3qYZtXCbz
         UPFoYClbwGGLAMwCNwCzL+90kk1naT8QQmFLWTOJ0um1jy6Pq1VrqRSPVGRc1j44ASou
         tLrIv2h81uNe8lzuyrfU9OY8pN8kqKj4g9yEaj7ZO+50O8xRTN2PvaNpeLn6Qdx0k8Gk
         hmT0LfRQZBdhqfSsOhFRLyIHj0PlfH3/RqkURK4PrVk1Itf7dcxpOHjioQfThJxzQpki
         qNwg==
X-Forwarded-Encrypted: i=1; AKwUvBwi4YzGnLz1Y7wt0IKPbRWHLFy3vuG3/6Gn9b5vsJs9fOxNiNVycSjZGsWzSm89xM+5tAgQ/yjk@vger.kernel.org
X-Gm-Message-State: AFq9FYI04qnGQYOkNL1WEqieS5hvLSBDCX1I+Sb6rhICz+Vakh+IHRbs
	W1ERS4XXoiZrVFHKJAsOOsBbfAavZKSTSmbvisTGJr4t74RSmJHDp89MYLyeBQ==
X-Gm-Gg: AYBFou2Y5u9NPF0qJTGDv/ZtzEdHwam957QNOh0TUDegfARCEU+0M5Vs2wY8GvB33vp
	5bHLj94b9kwrwjrH+r8tALA8igmn7uynk5IgRXPBleXcIN/RbxkfRcCAPXJ3gijVhhDLG31uVJr
	kjCjmep7gbrawt31QT2IAsX2EbTzMZuTIfHAFbLWSHAa6BlXOHcQguCwcc1EnXrILvEWG8fqyII
	/aRBW0OxIJwkKdAbJgFUCFoHCbNIiFzs50IqHUh9laWjIpTkteEr75+jAvyR6eMWXsKEXFbfki0
	6TDmvcCBRqOGTcBoJp8Ot9kK2ktSqD0+rNd89gKfP7WSydGHGCNDoalPzG5wJ/RmgOXrqLHOgwz
	FE8m9ZYRwYhw0b3fDPARUIJXMuKtNeg2bT7H7VobkLNmsNq3PXbRLA0uRBqOSRD2HHd5zARIzdV
	Nq3YigXACUvJbkEV+VTm+rMg+VymPD8cUY1IOpy31HD6cl5iEk87G0/9Wbrnr+rjicmmi7Y8dj6
	clYKS/DI7/oVVKpCqsiVBaLkJRZAKzov2RlZX4RTtKg/qN0Xa8I+Q==
X-Received: by 2002:a05:7301:fc82:b0:35d:84c2:eb27 with SMTP id 5a478bee46e88-369d986918fmr703493eec.35.1792714030379;
        Thu, 22 Oct 2026 17:07:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9db7970sm1525194eec.19.2026.10.22.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:07:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, xfs <linux-xfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.linux.dev>, fstests <fstests@vger.kernel.org>
Subject: Re: Farewell!
In-Reply-To: <20261016160037.GA107919@frogsfrogsfrogs>
Date: Fri, 23 Oct 2026 05:09:47 +0530
Message-ID: <fqxx5mpo.ritesh.list@gmail.com>
References: <20261016160037.GA107919@frogsfrogsfrogs>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list

"Darrick J. Wong" <djwong@kernel.org> writes:

> Hi everyone,
>
> After 14 years at Oracle and 23 years working on Linux, I've decided to
> take an extended break.  Today, October 16th, 2026, is my last day.

I was a bit sad to see this email :( But then I read it's an extended
break, so I am hopeful that we will see you around after your break.

>
> I don't have any immediate plans to drop the djwong@kernel.org
> forwarding, though ultimately that's up to the sysadmins to decide.
>
> I have very much enjoyed working with you all, and I'm proud of what
> we've accomplished together.  Good luck!
>

Thanks a lot for all your help throughout these years on mailing lists
and over other discussion forums. Really admire your maintainership
style.

I also feel lucky to have met you in person at LSFMM-2024 and to have
had long chats with you on all sorts of topics there :)

> --Darrick

Hope you have a good break! 

-ritesh
