Received: from mail.cn.fujitsu.com ([183.91.158.132]:45987 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbeHWEJM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Aug 2018 00:09:12 -0400
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute
 values
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
 <20180822135022.GK4723@thunk.org>
From: Su Yue <suy.fnst@cn.fujitsu.com>
Message-ID: <fc96a452-bec7-fbaf-961f-a8ff35567a5b@cn.fujitsu.com>
Date: Thu, 23 Aug 2018 08:48:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180822135022.GK4723@thunk.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 08/22/2018 09:50 PM, Theodore Y. Ts'o wrote:
> On Wed, Aug 22, 2018 at 04:32:01PM +0800, Su Yue wrote:
>> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
>> set and report empty attribute values) changed output format of
>> empty attribute value with quotes.
> 
> I think you mean starting with version v2.4.48, right?  "Since
> v2.4.47" can easily/commonly be interpreted as "Starting with
> v2.4.47".
> 
Yes, recent v2.4.48 contains the change.
Thanks.

Su

> v2.4.47 was released in 2013, and the commit in question (0550d2bc)
> dates from 2015.  v2.4.48 was released very recently, on August 17,
> 2018.
> 
> 				- Ted
> 
> 
