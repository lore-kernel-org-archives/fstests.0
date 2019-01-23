Received: from mx2.suse.de ([195.135.220.15]:40480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbfAWBiU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 22 Jan 2019 20:38:20 -0500
Subject: Re: [PATCH 2/7] filter: fix assumed whitespace in _filefrag_filter
 regex
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-2-jeffm@suse.com> <20190121225155.GG4205@dastard>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <02910403-e6c2-5af8-ebe6-c7fe19b7c02a@suse.com>
Date: Tue, 22 Jan 2019 20:38:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190121225155.GG4205@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/21/19 5:51 PM, Dave Chinner wrote:
> On Mon, Jan 21, 2019 at 11:33:11AM -0500, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> The regex assumes there will be whitespace after the .. in the ranges
>> and, with larger offsets, there may not be any.
> 
> Does more than this, right?

I suppose.  It converts the interpreted .. into a literal .., which I
believe was the original intent.

>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  common/filter | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/filter b/common/filter
>> index ed082d24..b4443a34 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -532,7 +532,7 @@ _filter_filefrag()
>>  		next
>>  	}
>>  	($ext, $logical, $physical, $length) =
>> -		(/^\s*(\d+):\s+(\d+)..\s+\d+:\s+(\d+)..\s+\d+:\s+(\d+):/)
>> +		(/^\s*(\d+):\s+(\d+)\.\.\s*\d+:\s+(\d+)\.\.\s*\d+:\s+(\d+):/)
> 
> This is escaping "..", too, isn't it? 

Yes, but what else could the .. in the original regex have been
referring to?  I don't recall seeing any other filefrag format that
would match otherwise.

I don't have a problem documenting it further, though.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
