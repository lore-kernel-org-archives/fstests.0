Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7B1B27F
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gjOz/ITS"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6591
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 04:48:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231031114846euoutp022fd8d645e48c0ecf901a650fd285fa47~TLslWf5x22077020770euoutp02E
	for <fstests@vger.kernel.org>; Tue, 31 Oct 2023 11:48:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231031114846euoutp022fd8d645e48c0ecf901a650fd285fa47~TLslWf5x22077020770euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698752926;
	bh=TQhutCtNYQ6kgjMonOHj0Ij28idaId7mLKj25Io9naU=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=gjOz/ITSB9tpqt9rOX1dwezefGKXPHpIcYusiEr2o3SBtVealZ/7whuGRdNz//SW/
	 0PEcmwMmYWIquu6ItN8AJKKkhokMYSBB5cXikbLhECmhOgTjVmdvpVljTRckGYNrGn
	 uzBYPOblJVo8sF4h/nTvTBrzpH0WTiAcpvQaDXCA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231031114846eucas1p186e999b16dbbaf4ec835a0a1514efdc7~TLslFNXyH2535425354eucas1p12;
	Tue, 31 Oct 2023 11:48:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 5A.5B.11320.E99E0456; Tue, 31
	Oct 2023 11:48:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231031114846eucas1p265dff558a287f315c5952c9907e6de89~TLskwZzY62722827228eucas1p2V;
	Tue, 31 Oct 2023 11:48:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231031114846eusmtrp18a99608d130ce5ba16acf6fc8bcc1219~TLskvzGWC2660626606eusmtrp1H;
	Tue, 31 Oct 2023 11:48:46 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-9a-6540e99e5bbc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 0F.DA.10549.D99E0456; Tue, 31
	Oct 2023 11:48:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231031114845eusmtip1bb45d6b4055f815c78b3503630c6f521~TLskm4V260247402474eusmtip1i;
	Tue, 31 Oct 2023 11:48:45 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 31 Oct 2023 11:48:45 +0000
Message-ID: <c51514a4-b643-42dc-9db0-5ec51b5e184a@samsung.com>
Date: Tue, 31 Oct 2023 12:48:44 +0100
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: redirect stderr to stdout in generic/269 and
 xfs/051
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Pankaj Raghav
	<kernel@pankajraghav.com>
CC: <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
	<gost.dev@samsung.com>, <mcgrof@kernel.org>, <djwong@kernel.org>,
	<fdmanana@suse.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <CAL3q7H5vTNDQkr5z+PEZu=wzDtjOfzQdBmHpj49BerWeFYgDvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87rzXjqkGtz9KGZx+QmfxfH9m1gs
	tn5uZrE43bKX3eLMy88sFjcmPGW02HtyJ6sDu8emVZ1sHmdXOnq833eVzWP9lqssHp83yQWw
	RnHZpKTmZJalFunbJXBlNGxczFhwn6Vi/4Um5gbGH8xdjJwcEgImEn+WvmXvYuTiEBJYwShx
	+tgeRgjnC6PEskuX2EGqhAQ+M0pcXpYN07Fm/SZmiPhyoI7HphANQDU7LnezQjg7GSUW7V7K
	AlLFK2AnsfTPY1YQm0VAVeLQxkVMEHFBiZMzn4DViArIS9y/NQNoGweHsECIROc/e5Aws4C4
	xK0n85lAwiICQRLHb1eCjGcWmM4o0fmhjQUkziagJdHYCXYnp0CgRGPTc0aIVk2J1u2/2SFs
	eYntb+dAfawoMenme1YIu1bi1JZbTCAzJQT+c0gc2/iYESLhIjHhwSeoBmGJV8e3sEPYMhKn
	J/ewQNjVEk9v/GaGaG5hlOjfuZ4N5CAJAWuJvjM5EDWOEtfXbmWCCPNJ3HgrCHEPn8SkbdOZ
	JzCqzkIKiFlIPp6F5IVZSF5YwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzD9nP53
	/MsOxuWvPuodYmTiYDzEKMHBrCTCe9jUIVWINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQ
	QHpiSWp2ampBahFMlomDU6qBKUKuwrChpVhy9+YDZ9bMvVxs3mO2bOe3FT9DjjXbZgv7rpz+
	/MncX0kuwuvdbjuyNVzYqHZz9aM1E0KqHq6JV/zA2ey/9v3eq33a15j6zJJeTqvPf/X/vZO3
	49JtvH3W1+KYPzY9KcnpU0udemv6qlguo7S/98NTsnltSnx/bJi2eMmNb3VLZqwPSOF5VbH4
	a/XLE7fXVrNP1PQVCclW7JwVIjhR5jLPl8rVWQ2aFt5OkjMWeqT/tmOvbdyhW+2iz3Di2K7j
	j35GVnxtS5b5JtW4b/1j02dcSjFRX+Slo0zLXxzdnLFN5eK9/5Piz+3Tcuo+9UOlUKvj5xod
	j1UPfsW6lHFaih8p+Dkh+eqCJiWW4oxEQy3mouJEAKLXq8iuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7rzXjqkGkx7zGhx+QmfxfH9m1gs
	tn5uZrE43bKX3eLMy88sFjcmPGW02HtyJ6sDu8emVZ1sHmdXOnq833eVzWP9lqssHp83yQWw
	RunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlNGxc
	zFhwn6Vi/4Um5gbGH8xdjJwcEgImEmvWbwKzhQSWMkpcn1ALEZeR2PjlKiuELSzx51oXG0TN
	R0aJ6Y+AbC4geyejxNmmRhaQBK+AncTSP4/BGlgEVCUObVzEBBEXlDg58wlYjaiAvMT9WzPY
	uxg5OIQFQiQ6/9mDhJkFxCVuPZnPBBIWEQiSOH67EmQ8s8B0RonOD20sELtuMkq8vfudEaSI
	TUBLorGTHaSXUyBQorHpOSPEHE2J1u2/2SFseYntb+dA/agoMenme6hfaiU+/33GOIFRdBaS
	62YhOWMWklGzkIxawMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBqtx37uXkH47xXH/UO
	MTJxMB5ilOBgVhLhPWzqkCrEm5JYWZValB9fVJqTWnyI0RQYRBOZpUST84FpI68k3tDMwNTQ
	xMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oqgemk0RypRKXXSe9bC+POCXB1e1du
	/7z4o0DVeaNjXvrZiQwpjxcsPtOb5DB5XtkVSc/pVa8eli/1L1Yyi7oaKrJ0z0dWKxX/y6wq
	3JMsJI2ZJ0xdsSXc3rzltZnoLYnJRs37j3fOF1Q5u3jbyetvrraaHeYvCX9z0fdku+GWxolx
	Ne7PA0SexWnt6ewMu/Yw+LyS8fMF0/44HV7ya9/NnhMCl9J+3WU+52+74aG6+WV+lm35y1UM
	vTIMnu+W3nlhc925Rac+Gv1WqZ3Kqv0gS6/se4bRxjltKr9k9f8G50Tw7pmzuUxN6PS/DU8k
	G+vOvl1RJL96f8mGFempEqX27es8y6yzbrP+WpB67sqVD2+UWIozEg21mIuKEwGr4oM3YwMA
	AA==
X-CMS-MailID: 20231031114846eucas1p265dff558a287f315c5952c9907e6de89
X-Msg-Generator: CA
X-RootMTR: 20231031114436eucas1p1cf068f314a5fb1377c5e3d044fc5998a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231031114436eucas1p1cf068f314a5fb1377c5e3d044fc5998a
References: <20231031111027.3367136-1-kernel@pankajraghav.com>
	<CGME20231031114436eucas1p1cf068f314a5fb1377c5e3d044fc5998a@eucas1p1.samsung.com>
	<CAL3q7H5vTNDQkr5z+PEZu=wzDtjOfzQdBmHpj49BerWeFYgDvg@mail.gmail.com>

>> Add the removed 2>&1 back in these two tests.
> 
> Wasn't this already fixed in the for-next branch?
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=bbeaf7d1cbf2db50549cdc95b4d2099748641b1c
> 
Ah, you are right. I am not too familiar with xfstests workflow, so I just pulled
the latest master and these changes were not there.

Thanks for the commit info. I will use for-next branch for now.

>>
>> Fixes: f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full instead of /dev/null")
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---

