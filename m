Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191D1BC20
	for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030729; cv=none; b=syAcr21SkpwzzU5U6E+dg8fi75FPek688L8hoyeLXW9qkfCNdEctajzcgotgGVPKBZcooLDarxCNkLRgF4EU7cI0Evo85vRZmBOewScP73oioi/OJAdh94x9KKWdBzzhMYEGcN/CieLb8MQ3Hc80PfRviDYTn/bvCy7zWPLMICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030729; c=relaxed/simple;
	bh=22r9pNAODxL8lTWLasFQFULka8LQkLyQPALlCyYF5bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5D8wz2t/oKRtZfSImN7qSYyUUdbJdV8100mdP7RNI7Z82ruhZeZva4nx3hRF4mX9dlrQB2CtV8JiCFEE8FdiGG0GtX2NFLja5hJncg/ucUF7aB46PAY+euZlGOvF4bu8WrwWP6PULgu1KkAQycwOiz1yHi37V/JKKybBTupfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WnDtT5ZK9z4f3jQv
	for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 09:05:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CB2641A018D
	for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 09:06:07 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4V+msJmA39XCA--.44029S3;
	Mon, 19 Aug 2024 09:06:07 +0800 (CST)
Message-ID: <ac950efd-57af-02ff-ccaa-b50baff30de7@huaweicloud.com>
Date: Mon, 19 Aug 2024 09:06:06 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] generic/732: remove unused code
To: Zorro Lang <zlang@redhat.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <ZqekL92fZP9cxe2h@infradead.org>
 <ed1a16d0-cc1e-005a-e0a2-9c08cb71caee@huaweicloud.com>
 <20240817191611.ohxdvqtwx5nskqct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240817191611.ohxdvqtwx5nskqct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4V+msJmA39XCA--.44029S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5E7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/8/18 3:16, Zorro Lang 写道:
> On Sat, Aug 17, 2024 at 02:24:26PM +0800, yangerkun wrote:
>> Hi,
>>
>> Ping for this patchset.
> 
> Is there anything wrong? This patchset has been merged as:
> 
> 50da3fd9 generic/732: don't run it on tmpfs
> 52a36bfb generic/732: remove unused code

Sorry! I have not notice that this patchset has been merged to 
patches-in-queue.

> 
> Thanks,
> Zorro
> 
>>
>> 在 2024/7/29 22:16, Christoph Hellwig 写道:
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>>

