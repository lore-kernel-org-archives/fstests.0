Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249460;
	b=oxGi7FXjfDnuPmYXEVVlyS18QSbGCx8S1NOyYrm8E2jS4UkKcV/tCOYil1QVCM342RpS
	 QeoU5ic1Hy7T+IiAs7j6SrgL13vpSNmJK9rNEWFzIDoW4qhL3gcMYBAu593r8KhMl747V
	 4Ny77Ql2QEjCKY2JsR+bpMdYELa2tf+UxbPt+uGYLboFfJ6H/rqUuRY3KFBqJ6dDC1g6G
	 3p7aogsFxGuawJ5IPMuY3QzBUKqeSxL2KYYdla0YxkDLZQ+O3idJLlCgWfytJg3iJ3rgy
	 lNc1uVuRmGBF1tzj0ELDWt3hXLjxG7Oa70Wgm5hAEPEL4tomoVWgBEw2FuldgCR3iJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gQWTo3YG2SkoMfnNaAKg/+Z4r1WHLc60eAAlSKMJVuk=;
	b=x8kM6a6ysTlgZtnntea0RaqqdDz1q/i8Rhv4rGiTJFvs0IldGmDQkd4lef1eTgl62Qu2
	 zNCYkbbnF+ksymbKLVpMAeEAjM5xRQ0EXtG9ML4HKppqT56zaumkIaVcy60PVlEkVAZCc
	 ol7dNf4L0Zpoj8XzIszXX+Zk2HiYTs33ULHngaYBbMghM+peDYHYrgwhyd1+ap3phGtpP
	 KWa48IUsVmlDKOy1MjKJ+0gJTBeSIF5tzixTczYNVLcfbi7KYn0nhS4L3jzbaaSNeCuW0
	 soCAyPcHRsAKNV1/rLTJYT7OqVb3T5+mP02L+KY5IESqix0PGTKEw402hZmSvYoptMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hEGrzXMk;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=nlhzqxUr;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC11606A31C
	for <fstests@vger.kernel.org>; Mon,  9 Nov 2026 18:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=hEGrzXMk;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=nlhzqxUr
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HYscG1791698
	for <fstests@vger.kernel.org>; Mon, 9 Nov 2026 13:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=gQWT
	o3YG2SkoMfnNaAKg/+Z4r1WHLc60eAAlSKMJVuk=; b=hEGrzXMkOGM79q+eIdlN
	bTCWWlnY2PfeTY4s3cMCb7D3NBGF1ZnmHU1JPiF/VWcpeFrOJVVCTt2V8SfgIhE9
	gLJg4bRDQAfhger9vg1nqfLN3/n/VyKzQDRMcwGmMziP0gF2c0fBBGK6kNGipFWD
	sO2vsKKXzL06GtKPS8/8Rsm5F/5kKUwIunLKAuI88qHBXpP26iU1GbE607fPvlaV
	Iu3FqLa/flAkgS2ScNFSuKzIcyaexj7HN4p6kfCadVcef19UFqtV/u9HpF10HosT
	Qe7vkqNC2MrAEFRnI5WaWk2CE7gA+PRd1WTPMDCn9n6I+oLbQUaNMG9zr6TXwKIL
	Tw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4huejykeqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Mon, 09 Nov 2026 13:37:36 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-946811b8f8cso120764685a.3
        for <fstests@vger.kernel.org>; Mon, 09 Nov 2026 10:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794249455; x=1794854255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQWTo3YG2SkoMfnNaAKg/+Z4r1WHLc60eAAlSKMJVuk=;
        b=nlhzqxUrI0fI7/fbDMyAzVd70Zt76jatity3GeLCzTcjGYZW0FjNLTNnAkhjmj4YJb
         DKRVGedQqIiL57xWEB3B3E6XbB0F9MvrT+FlgdcGOWXHuJg1YzLjDtGUUi8mNJmW41p6
         RSSlxAl/+umrf1WMwb7r0t00XLZ7NOt9VOVxGKsfcGGb4BjFa3lST8/3lp7Jyom5UV2g
         S7UY5JT8CgpaOQvrbAfAFxNCLNMOn6h+soKKPhOAxzL+lVqNNstiIFcbzkVXS0pIl45q
         2e0HUsAt1U6IWIov54YpLUXFcVQE1VcJK4jYORhGWUYcdNA3hwJivoWdMnEO0SuqvKyo
         b18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249455; x=1794854255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQWTo3YG2SkoMfnNaAKg/+Z4r1WHLc60eAAlSKMJVuk=;
        b=bVloLgStqHWza0ObXeS7GPK8m2W1IN6mJwg7pfSEFZ0R3LmMAy7XpCuz5XuBS9OOZO
         R+qsy0+BshF5JtdQJ6txiG1WHSXNuY1ryGjigZip8UAIFoyblZMXJBABmrVtNNtee1n0
         aM9OcTK8hjWqQn9eiNVPOwzbiFP5j2eAIHyDZb5DyNnRjTxjdqSD9FchqlUDxc/XF+tD
         lXYCQMlbpUtI8YTWjhKh1TyoeYGTTtYRoeeaVH5tmAbguENMwLoedBRCibDsOg4v/Ngm
         /Q+YgN81BXI9iFJ0CNkINeb7ena5Zx5E31GmZ4q6z+M4gslfS8rFuQw9MVk7Z9Z963De
         vSWA==
X-Gm-Message-State: APuU4Z/X5mpN2sVfmVnE13LLmwdiTynblYrOXXw4RmHjkskz3c9zPG3x
	usuyG3SXHOJRygTuiL+SvFTx0so1RDI0cySx3WJIgr90SLwIwwzAjSLCYpWT7lUY2Ch+pOFpRqJ
	8/tF3lyInAWZ8iIhqAId/kPmjIGUQyDBPJHhLkA1B/htbYeNrOQuPjz4=
X-Gm-Gg: AYBFou10P4PKsOF9qWIQYWEg91FfC43jpbI2FBK2nGqwoQHdNxbkTAhLNE/RJOZyVfs
	MT4ZVJVieDLqxLieAT4+vYXfgI1Yg3vbVZpPH+oRNVlVTQhULaDbesQNGLX7ixc2bQr6MgLKgBC
	vyB+BSf+CMk8FIBjrE2ho4Pu3RTMvhkrEzrrCRI6R+ufLDuY81osC6mMCMu9tO62xioR4Q7ziBM
	fpyasrrmNnvIiBL4W7lQ5zAyrvJd7SAizjxFotJ5d4HV0A80etyz9eHDNTK9RktWYiOXXWwjK+q
	CPr5A08LZA0K7TyjfUFGqFlFqzMeVNx2n9Wqp1QWmI8BY8EIvArUYDynV2NL0Fp2HcNR1hzqJRZ
	Q0fsUfRdJRYIoBwZ39Dxx99V6uzVYlMUeh9IlBD9BSjKeoPivHa9Vev/q5hDZY/P46J5QQQUOCT
	bdoK+kOEt/Phvm12uAGQCLm2k=
X-Received: by 2002:a05:620a:1b96:b0:946:123a:bdd0 with SMTP id af79cd13be357-9479f30e6a8mr52109385a.48.1794249455433;
        Mon, 09 Nov 2026 10:37:35 -0800 (PST)
X-Received: by 2002:a05:620a:1b96:b0:946:123a:bdd0 with SMTP id af79cd13be357-9479f30e6a8mr52105085a.48.1794249454971;
        Mon, 09 Nov 2026 10:37:34 -0800 (PST)
Received: from [10.207.116.169] (nat-128-59-178-16.net.columbia.edu. [128.59.178.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c3ddsm36187685a.15.2026.11.09.10.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:37:34 -0800 (PST)
Message-ID: <99a9c7a2-d2f1-4308-bb4a-67217ed377f6@columbia.edu>
Date: Mon, 9 Nov 2026 13:37:33 -0500
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] generic/810: check that RWF_DONTCACHE I/O drops
 its folios
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
 <20261107-dontcache-test-v2-3-7655bf08d6d1@columbia.edu>
 <avHUTwnSMVCkKVoW@bfoster>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avHUTwnSMVCkKVoW@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o5PBpEDOPm_DnNX7STgku2eAYgosJAvv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX6LPbhI4g49kc
 92lyliu7J9JZ1jI7KMBLuVIBOjm4XNLbPacQmq8PtMaLSbK7V/pKcXxlzpgWSi4T6tojpaJi55Q
 xLEaTmqMHx/QYzqG+w6DWAOoSlMv+MykrbuupK4W/6K1gMbn/X93zqICcbUHeOZ31y7ud7YiiKQ
 tDNcPhbPUVqB1t+fkXJhNwdZD0XJGQdewcf7YJ/dktwHfvxQ+IM2P6MaKaDS/Uj0xkpHisRQSK9
 dbsWxFg27W0SJQ8iO+kXJ5G40j5oqmigFWbLyvgqFzt9cjqrangHMioFnHGAihRb+8B0cj0D652
 ArLzGMa3/QSEty+8S+cqc4uet5e8wfkMVemSqo1vgCwHk2HAO9u8qqvGiBJgdKwycgpQyhp+MLL
 NR/lGINNZE6Tu3qhp2PUTYpeGVA3jbevOhCok4GdSW/Dl3uC4cvvCZUFY9xGQDks5u6CyeIGGIf
 cdSwVnNe4YJ6Fgo18bw==
X-Proofpoint-GUID: o5PBpEDOPm_DnNX7STgku2eAYgosJAvv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX4rGl1xLAXijv
 3UwqfJikkCR8G2G0gVI1g7rNSlUWZszERuXMjq47QmFbjlBqyH0SGuZhtlbF/npCpBIO/l0Rh2V
 dD2tNe+6fT2SZHb2ouZbkalgx9dChWP2Waca8aWJ8Mf8xV+TZdIB
X-Authority-Analysis: v=2.4 cv=ee2o7LEH c=1 sm=1 tr=0 ts=6af212f0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Gl6UJ28otdLh1ydVN8wMBg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=20KFwNOVAAAA:8 a=LFmhLChh9ExO1iPAI9sA:9 a=QEXdDO2ut3YA:10 a=2EJJ2Fb71GoA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11961
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=10 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=10
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090074



On 11/9/26 9:10 AM, Brian Foster wrote:
> 
> I like it. Thanks for the tweaks!
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
Thanks, and thanks for the review! The end result looks cleaner.
