Received: from mx2.suse.de ([195.135.220.15]:38228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeEANep (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 May 2018 09:34:45 -0400
Subject: Re: [PATCH] check: annotate good and expunged tests in results
From: Jeff Mahoney <jeffm@suse.com>
References: <20180412213838.28929-1-jeffm@suse.com>
 <20180424093646.GA11384@desktop>
 <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
 <20180427112356.GP11384@desktop> <20180427170009.GT27853@wotan.suse.de>
 <20180428024545.GR11384@desktop>
 <33a80b8a-fe26-faee-9704-d1bb2c933a3a@suse.com>
Message-ID: <21a3f3ab-b439-9851-8258-4e3e7f9ca472@suse.com>
Date: Tue, 1 May 2018 09:34:41 -0400
MIME-Version: 1.0
In-Reply-To: <33a80b8a-fe26-faee-9704-d1bb2c933a3a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On 4/30/18 4:48 PM, Jeff Mahoney wrote:
> On 4/27/18 10:45 PM, Eryu Guan wrote:
>> On Fri, Apr 27, 2018 at 05:00:09PM +0000, Luis R. Rodriguez wrote:
>>> On Fri, Apr 27, 2018 at 07:23:56PM +0800, Eryu Guan wrote:
>>>>
>>>> But the test run & pass info is already available from the check output
>>>> and the test result summary at the end of check. Is that sufficient for
>>>> you? Also, we already have mechanism to generate a test report in xunit
>>>> format, i.e. ./check -R xunit -g auto, which includes results for passed
>>>> & failed & notrun tests.
>>>
>>> Do we have a way to parse the results *after* a run? For instance,
>>> if you forgot -R xunit ?
>>
>> There's a tools/compare-failures script that takes the outputs of check
>> as inputs and compares the results. But, TBH, I never run it after
>> reviewing it.. Perhaps it could be enhanced somehow.
> 
> Yeah, that takes check output.  Without capturing it at runtime, it
> can't compare anything.
> 
> The XML report may do most of what I want provided we can enable it by
> default and write it someplace safe rather than clean it up
> automatically when the test run is interrupted.
> 
> I already have test code that extends it to output expunged tests and to
> add an explicit <pass/> element.  It saves the timestamps already, so
> that's a plus.

And shortly after writing this, I had a test run hang.  Since it hung,
even writing it on exit wouldn't have worked.  There's not enough
information leftover to generate it.  I think I'd still like the results
directory to contain the information required to generate it as a
post-mortem.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
