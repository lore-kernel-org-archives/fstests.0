Received: from mx2.suse.de ([195.135.220.15]:40500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbfAWBis (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 22 Jan 2019 20:38:48 -0500
Subject: Re: [PATCH 3/7] filter: add support for old filefrag -v
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-3-jeffm@suse.com> <20190121225343.GH4205@dastard>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <18b7b2ca-1ced-3140-ab00-74aa0f6484fd@suse.com>
Date: Tue, 22 Jan 2019 20:38:45 -0500
MIME-Version: 1.0
In-Reply-To: <20190121225343.GH4205@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/21/19 5:53 PM, Dave Chinner wrote:
> On Mon, Jan 21, 2019 at 11:33:12AM -0500, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> e2fsprogs versions prior to v1.42.7 had a different format for
>> filefrag -v that is incompatible with the regex in _filefrag_filter.
>>
>> This patch adds support for the older format to test on older releases
> 
> Can you document what the two formats are in a comment just so it is
> somewhat easier to check the regexes are, indeed, doing the right
> thing?

Sure.  That's easy enough.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
