Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9A158DDC
	for <fstests@vger.kernel.org>; Wed, 24 Jul 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827503; cv=none; b=Pm1xt118QtQH71SKruiMY6Z2zYJgOofalFjQpfK7s4OAGH1aNSikxwEcTr/WinR1qtmI/VyzjBHTPt9tHRh3CrpGyshQ54ee8z0QTnQCp9fXFEArHtL4GoZUUPBolicE9mtV/HwuI8Aap44rhTO2vqzllbGPeKyBRW0QaVGacpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827503; c=relaxed/simple;
	bh=tOtyl6CMe+zOwJ0wDfVq43MA3PQ8/fOF08QjWnTAnd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Emf+Pa0dbrgXZ+hJhNFtIShaHuhjy5CARTRKGO+sMaz9CMkGsWFT3oGdW/4RcjQfENvnpzxgsInrKuIUE3qpcNm5MRO9jK8zyjtDE2l8Y/zeF5pHvn+x16AtuVF7u2Nyuc8WTcAlo8fNvpDjn20HmK+zUsUG6xjGQ29xQmb3GIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WTZW61v2WzxTlF;
	Wed, 24 Jul 2024 21:24:50 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id BEBBE18009D;
	Wed, 24 Jul 2024 21:24:52 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jul 2024 21:24:52 +0800
Message-ID: <8ce6def6-080e-eb2d-2ba9-32eabeac58c8@huawei.com>
Date: Wed, 24 Jul 2024 21:24:51 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] generic/732: don't run it on tmpfs
To: Christoph Hellwig <hch@infradead.org>
CC: <zlang@kernel.org>, <fstests@vger.kernel.org>, <linux-mm@kvack.org>,
	<hughd@google.com>, <akpm@linux-foundation.org>, <yoyang@redhat.com>
References: <20240720071323.2893437-1-yangerkun@huawei.com>
 <Zp5qnY-C_GXnn7ts@infradead.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <Zp5qnY-C_GXnn7ts@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi,

Sorry for the delay relay(something happened, and cannot use pc
before...).

在 2024/7/22 22:20, Christoph Hellwig 写道:
> On Sat, Jul 20, 2024 at 03:13:23PM +0800, Yang Erkun wrote:
>> Like what 4fd042e0465c("generic/732: don't run it on NFS") say, the same
>> options for tmpfs won't share the same backend. Skip it for tmpfs.
>>   
>>   # real QA test starts here
>> -_supported_fs ^nfs ^overlay
>> +_supported_fs ^nfs ^overlay ^tmpfs
> 
> Can you please spell out the explanation here?
> 
> We should not have a _supported_fs call without a comment explaining it.
> 
> 

Yeah! Thanks for your reminder, will do it with v2(maybe until last week 
I can do it).
