Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC55187860
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263314; cv=none; b=WtOIQDELGx44pbGBtPq9MuDiCPX00BNzvveZuWsXtqYtLIIKacMnJH6cu/jHC3WB4rajaDnoB7gSy+ITuLhQARJjD42JVh++zbPl3KpqFBsvDHLcMLwiTEe4gK6GEfQj/wNAyLhWSaSYq68d6SsdJg6b+ktWag8OnPANuMpKoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263314; c=relaxed/simple;
	bh=UxsgXu2x4oVsIakYNvh/rkKJ0Fnwg5nIKJvsoNlC8cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a1dXxf0zKo6i1yZH+pboxOpSUV73Fde+l1nmdlJjXox6mGES67Weh/TpoGuhX3Ph9Jf05aPSL7HuT4NVXsNG96k/mm7dqvRRat0a/B8Ksvp7Lf1lICZoK5lGrmtn37KdMzIp81KzcMLsqSi7YrH/tPZOXFvijY1Dk7CSG9hnxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXgg75HDCznbr0;
	Mon, 29 Jul 2024 22:27:31 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EFE41800A2;
	Mon, 29 Jul 2024 22:28:28 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:28:27 +0800
Message-ID: <b2096645-6b24-70c2-aea0-361fc5984d5e@huawei.com>
Date: Mon, 29 Jul 2024 22:28:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] generic/732: don't run it on tmpfs
To: Chuck Lever III <chuck.lever@oracle.com>, Christoph Hellwig
	<hch@infradead.org>
CC: "zlang@kernel.org" <zlang@kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Hugh Dickins
	<hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	"yoyang@redhat.com" <yoyang@redhat.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <20240729084715.1736839-2-yangerkun@huawei.com>
 <ZqekPERYzP93HacM@infradead.org>
 <D332E074-6760-4EC1-B3C6-437C1C52229C@oracle.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <D332E074-6760-4EC1-B3C6-437C1C52229C@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/7/29 22:21, Chuck Lever III 写道:
> 
> 
>> On Jul 29, 2024, at 10:16 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
> 
> I would prefer this test continue to run on tmpfs.
> 
> tmpfs is broken, and needs to be fixed. If the generic/732
> failure is an issue, then add it to the expunge list --
> it found a real bug, that, once fixed, we don't want to
> reappear.

The reason why I thinks it should not run for tmpfs is that the same 
mount options won't share the same sb. I prefer it's a expected behavior...


> 
> 
> --
> Chuck Lever
> 
> 
