Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB04C433DF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 01:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C4B20780
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 01:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgGABHi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:07:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22463 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgGABHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 21:07:38 -0400
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="95596850"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Jul 2020 09:07:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 2EB474CE4BD6;
        Wed,  1 Jul 2020 08:56:38 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 1 Jul 2020 09:07:07 +0800
Message-ID: <5EFBE1B9.4020805@cn.fujitsu.com>
Date:   Wed, 1 Jul 2020 09:07:05 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Xiao Yang <ice_yangxiao@163.com>, <fstests@vger.kernel.org>,
        <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 6/6] xfs/260: Move xfs/260 to generic
References: <20200617093204.20838-1-ice_yangxiao@163.com> <20200617093204.20838-7-ice_yangxiao@163.com> <20200617214857.GN4160762@iweiny-DESK2.sc.intel.com> <a2b565a7-7ff8-7201-1921-4724d8117cbb@163.com> <20200619151511.GR4160762@iweiny-DESK2.sc.intel.com> <5EF1C293.4010104@cn.fujitsu.com> <20200623180803.GE3910394@iweiny-DESK2.sc.intel.com> <5EFAE502.6060805@cn.fujitsu.com> <20200630155058.GT2617015@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200630155058.GT2617015@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 2EB474CE4BD6.AC6E7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/6/30 23:50, Ira Weiny wrote:
> On Tue, Jun 30, 2020 at 03:08:50PM +0800, Xiao Yang wrote:
>> On 2020/6/24 2:08, Ira Weiny wrote:
>>> On Tue, Jun 23, 2020 at 04:51:31PM +0800, Xiao Yang wrote:
>>>> On 2020/6/19 23:15, Ira Weiny wrote:
>>>>> On Thu, Jun 18, 2020 at 11:35:56PM +0800, Xiao Yang wrote:
>>>>>> On 6/18/20 5:48 AM, Ira Weiny wrote:
>>>>>>> On Wed, Jun 17, 2020 at 05:32:04PM +0800, Xiao Yang wrote:
>>>>>>>> From: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> [snip]
>>>
>>>>>>>      }
>>>>>>> @@ -124,17 +151,11 @@ do_tests()
>>>>>>>      # make xfs aligned for PMD fault testing
>>>>>>>      _scratch_mkfs_geom $(_get_hugepagesize) 1>>    $seqres.full 2>&1
>>>>>>> -# mount with dax option
>>>>>>> -_scratch_mount "-o dax"
>>>>>>> -
>>>> Hi Ira,
>>>>
>>>> Why do you want to remove this combination(i.e. test per-inode DAX flag
>>>> under mounting with dax option) ?
>>>> Is it because mounting with dax option ignore FS_XFLAG_DAX flag?
>>>> I think it is a reasonable combination. :-)
>>> Yes running with the DAX mount option really does not test anything IMO.
>> Hi Ira,
>>
>> Sorry for the late reply because I was busy with other tasks last week. :-)
>>
>> After reading related code, setting/clearing FS_XFLAG_DAX have no chance to
>> change S_DAX
>> flag if mount with dax option, so I will remove this combination in v3
>> patch.
>>
>>>>>>>      tsize=$((128 * 1024 * 1024))
>>>>>>> -do_tests
>>>>>>> -_scratch_unmount
>>>>>>> -
>>>>>>>      # mount again without dax option
>>>>>>>      export MOUNT_OPTIONS=""
>>>>>>> -_scratch_mount
>>>>>>> +_scratch_mount "-o dax=inode"
>>>>>>>      do_tests
>>>>>>>      # success, all done
>>>> Could we keep _scratch_mount without dax so that this test can run on both
>>>> old and new kernel?
>>>> See the following reasons:
>>>> 1) FS_XFLAG_DAX was introduced by commit 58f88ca("xfs: introduce per-inode
>>>> DAX enablement") since 2017.
>>>> 2) _scratch_mount with dax=inode is equal to _scratch_mount without dax.
>>> I suppose that would be ok.  But being generic what happens when this runs on
>>> FS's which don't have the FS_XFLAG_DAX flag?  is it ignored?
>> Test will report notrun by _require_scratch_dax_iflag() If fs doesn't
>> support FS_XFLAG_DAX flag.
>>
>>> FWIW I believe that any FS (which includes older kernels) which do not support
>>> dax=inode have no need for this test to run.  The use of FS_XFLAG_DAX on older
>>> xfs does not do anything and simply does not exist elsewhere.  Only FS's which
>>> support dax=inode have behavior which needs to be tested IMO.
>> I just want to test FS_XFLAG_DAX on older xfs by keeping _scratch_mount
>> without dax because
>> the original test(i.e. xfs/260) is designed to test this point. :-)
> Sure you can test swapping the flag itself but it really does nothing.
>
>> BTW:  It seems that older xfs can do dax mmap by setting/clearing
>> FS_XFLAG_DAX, or do I miss something?
> No it can only use DAX with '-o dax' mount option.  Changing FS_XFLAG_DAX on
> xfs prior to 5.8 is effectively a no-op as the S_DAX flag would not be set.
>
> See "742d84290739 xfs: disable per-inode DAX flag"
Hi Ira,

Ah, I actually missed the marco disabling per-inode DAX flag.
OK, I will use dax=inode directly in v4 patch.

Best Regards,
Xiao Yang
> Ira
>
>> Best Regards,
>> Xiao Yang
>>> Ira
>>>
>>>> Best Regards,
>>>> Xiao Yang
>>>>> .
>>>>>
>>> .
>>>
>>
>>
>
> .
>



