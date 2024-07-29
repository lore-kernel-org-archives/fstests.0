Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B81527AC
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263407; cv=none; b=cDJ68XLXtD06gV9kYW4v4Q6QD6ncoLi+q/J7y94lfyq9It7fKk4QOh8v7ndKSm6j2WsoE/e7KmPz0YW/txIPGUSP5djKap3ZMIO4kS1XBMXej8DnKPZpCtqF6sJ0XpHOtq3Y0r7k64D5lDpIWWw++Wn+267BEKldhLOBx5+dwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263407; c=relaxed/simple;
	bh=DfhO68V4ehVKGQH8WnnXPatpF6NeUGqZywXZpqtfRcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EX1Csa46MNmzWBwskq3L1MLw9GiEIwfyXyaIOYnNHBr+94k+pr2yk9sfYn0irxsmp0X3rc/t51k55JziGwVF5eOAu7o+T/H4ErXzDmPbL5Q8TXvF5P0xNfUzEuRRQCE1nel7Nr+tQmsvgOOjMulU/e6lQoci6aohjtyMUfg/JuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXgd61FtPzPtKM;
	Mon, 29 Jul 2024 22:25:46 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AF26180064;
	Mon, 29 Jul 2024 22:30:03 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:30:02 +0800
Message-ID: <b24149f5-584a-86fb-0922-2413391f58d8@huawei.com>
Date: Mon, 29 Jul 2024 22:30:01 +0800
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
 <4E63C821-3231-4939-980C-D2F904138518@oracle.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <4E63C821-3231-4939-980C-D2F904138518@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/7/29 22:24, Chuck Lever III 写道:
> 
> 
>> On Jul 29, 2024, at 10:21 AM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>
>>
>>
>>> On Jul 29, 2024, at 10:16 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>
>> I would prefer this test continue to run on tmpfs.
>>
>> tmpfs is broken, and needs to be fixed. If the generic/732
>> failure is an issue, then add it to the expunge list --
>> it found a real bug, that, once fixed, we don't want to
>> reappear.
> 
> Never mind.
> 
> Christoph, you deleted the context for this, and the
> Subject: was one character different than the one for
> generic/736. Even properly dosed on caffeine I missed
> that.

Aha, got it.

> 
> --
> Chuck Lever
> 
> 
