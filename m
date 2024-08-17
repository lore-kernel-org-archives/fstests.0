Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5E81ACA
	for <fstests@vger.kernel.org>; Sat, 17 Aug 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875874; cv=none; b=oBq8eWucWjIvERgERAHbqCjUwADZ2lnJaxBevErsergK7UqLQPWIAG7ftRajPbR1k+vixuj9HVvIiyhvgjQlF7jB/NNjnygwFs1w8QDBCqN36Vf5ccAuRoDHMcUXbdSqCE/ogdlEEZfHszz/wfGopv+k0mB8fBIAGBcT0h5gwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875874; c=relaxed/simple;
	bh=Zpt4ITDdSdn4R98fBK9PmnvBdlznJigvphL9GlUZkoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Upip5B9DYgzMvJfdXHURWLdVbptV2z7E6DjP9K/GwbDEiP0dGQtv7yXy6b+/0sVvduOLUzWG0zYZMlJJqqLaeNprBQA+tNqpuojrPLovbwIwWnZrFgHDTEaE4V4UeoMticXWcaxZGC6SukZknejKIiULCc7aZHLO7zxI8uG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm82k1kRZz4f3jHc
	for <fstests@vger.kernel.org>; Sat, 17 Aug 2024 14:24:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2BD371A0568
	for <fstests@vger.kernel.org>; Sat, 17 Aug 2024 14:24:28 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoQaQsBmELywBw--.34433S3;
	Sat, 17 Aug 2024 14:24:28 +0800 (CST)
Message-ID: <ed1a16d0-cc1e-005a-e0a2-9c08cb71caee@huaweicloud.com>
Date: Sat, 17 Aug 2024 14:24:26 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] generic/732: remove unused code
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <ZqekL92fZP9cxe2h@infradead.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <ZqekL92fZP9cxe2h@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoQaQsBmELywBw--.34433S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5_7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
	8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi,

Ping for this patchset.

在 2024/7/29 22:16, Christoph Hellwig 写道:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

