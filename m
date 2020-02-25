Return-Path: <SRS0=l1QL=4N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25264C35DF2
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Feb 2020 06:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87D20732
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Feb 2020 06:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgBYGEI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:04:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27248 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYGEI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Feb 2020 01:04:08 -0500
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="83887696"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Feb 2020 14:04:05 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9BD3650A9967;
        Tue, 25 Feb 2020 13:54:14 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 25 Feb 2020 14:03:56 +0800
Subject: Re: generic/269 hangs on lastest upstream kernel
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     fstests <fstests@vger.kernel.org>
References: <20200213211011.GB6600@quack2.suse.cz>
 <062ac52c-3a16-22ef-6396-53334ed94783@cn.fujitsu.com>
 <20200214150059.GA22815@quack2.suse.cz>
 <a0b06474-f447-7943-1012-2a8d20b9e352@cn.fujitsu.com>
 <20200218082436.GF16121@quack2.suse.cz>
 <83cc6208-3fa3-86bb-eb91-77b90b22d98f@cn.fujitsu.com>
 <20200218110311.GI16121@quack2.suse.cz>
 <b0b82e0c-0e86-af5e-5a61-2fafb2ca85a0@cn.fujitsu.com>
 <73af3d5c-ca64-3ad3-aee2-1e78ee4fae4a@cn.fujitsu.com>
 <20200219124324.GO16121@quack2.suse.cz> <20200219152020.GH330201@mit.edu>
 <27bea3a0-7a72-a924-644a-eece4bef97a2@cn.fujitsu.com>
Message-ID: <e844b86b-658e-519a-d8e7-f099fdc353bb@cn.fujitsu.com>
Date:   Tue, 25 Feb 2020 14:03:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <27bea3a0-7a72-a924-644a-eece4bef97a2@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 9BD3650A9967.AC1A9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/20 9:35, Yang Xu wrote:
> 
> 
> on 2020/02/19 23:20, Theodore Y. Ts'o wrote:
>> On Wed, Feb 19, 2020 at 01:43:24PM +0100, Jan Kara wrote:
>>> This means, fsstress command has queued cache flush request (from
>>> blkdev_issue_flush()), this has been dispatched to the driver ('D' 
>>> event)
>>> but it has never been completed by the driver and so 
>>> blkdev_issue_flush()
>>> never returns.
>>>
>>> To debug this further, you probably need to start looking into what 
>>> happens
>>> with the request inside QEMU. There's not much I can help you with at 
>>> this
>>> point since I'm not an expert there. Do you use image file as a 
>>> backing store
>>> or a raw partition?
>>
>> This is looking more and more like a Qemu bug or a host OS issue.
>> Yang is using a two year old Qemu (qemu-kvm-2.12.0-32.el8+1900+70997154)
>> and is using a QCOW backing file.  It also could be a host kernel bug,
>> although that's less likely.
>>
>> Yang, any chance you could have a chance to upgrade to a newer version
>> of Qemu, and see if the problem goes away?  If you have a RHEL support
>> contract, perhaps you could file a support request with the Red Hat
>> help desk?
> Of course, I will update lastest qemu to test.(I don't have their support).
Hi Ted, Jan
     I have updated lastest qemu(4.2.0), it still hangs. But I think it 
is not fs problem. Because it only failed when disk uses IDE bus, I use 
scsi bus, it passed. Thanks for your analysis and help.

Best Regards
Yang Xu
>>
>>                                              - Ted
>>
>>
> 
> 


