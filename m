Return-Path: <SRS0=Jk7F=BU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793AC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7489120678
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 14:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHJOJp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:09:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39620 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbgHJOJo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Aug 2020 10:09:44 -0400
X-IronPort-AV: E=Sophos;i="5.75,457,1589212800"; 
   d="scan'208";a="97940533"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2020 22:09:30 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id D62E44CE34EF;
        Mon, 10 Aug 2020 22:09:28 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 10 Aug 2020 22:09:30 +0800
Message-ID: <5F315518.2040907@cn.fujitsu.com>
Date:   Mon, 10 Aug 2020 22:09:28 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     Eryu Guan <guaneryu@gmail.com>, <fstests@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 59d1f998fd61
References: <5f3030bc.1c69fb81.7519b.378d@mx.google.com> <5F312B85.5040002@cn.fujitsu.com> <20200810120713.GD80581@e18g06458.et15sqa>
In-Reply-To: <20200810120713.GD80581@e18g06458.et15sqa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: D62E44CE34EF.AF11B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

于 2020/8/10 20:07, Eryu Guan 写道:
> On Mon, Aug 10, 2020 at 07:12:05PM +0800, Xiao Yang wrote:
>> On 2020/8/10 1:21, Eryu Guan wrote:
>>> Hi all,
>>>
>>> The master branch of the xfstests repository at:
>>>
>>> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>>
>>> have just been updated. The most notable change is the DAX patchset from Xiao
>>> Yang, which update&  add new tests to test the new DAX mount behavior. Many
>>> thanks to Xiao Yang for the patchset, and to Ira Weiny and Darrick J. Wong for
>>> reviewing the patches!
>> Hi Eryu,
>>
>> Thank you for applying my patch set. :-)
>> In addition, I also updated some helpers related to new dax option by
>> another
>> separate patch set[1] and hope you can apply it in next update.
>> [1]:
>> https://www.spinics.net/lists/fstests/msg14360.html
>> https://www.spinics.net/lists/fstests/msg14359.html
>> P.S. The patch set has been reviewed by Ira Weiny.
> Thanks for the heads-up! I thought you've folded all dax-related patches
> in the big patchset.. Would you please resend above two patches? with
> Ira Weiny's reviewed-by tag?
Hi Eryu,

Sure, I will send v3 patches with some changes soon.

Best Regards,
Xiao Yang
> Thanks,
> Eryu
>
>
> .
>



