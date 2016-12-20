Received: from sandeen.net ([63.231.237.45]:51884 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933960AbcLTN5e (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Dec 2016 08:57:34 -0500
Subject: Re: [PATCH] generic/395: test GETNEXTQUOTA near INT_MAX
References: <a3c43ff2-c641-aba4-b10e-781a3f3c86e3@redhat.com>
 <20161220062532.GL1859@eguan.usersys.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <41b17c2c-c4a9-0eca-7781-9c93ff3d8df4@sandeen.net>
Date: Tue, 20 Dec 2016 07:57:32 -0600
MIME-Version: 1.0
In-Reply-To: <20161220062532.GL1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 12/20/16 12:25 AM, Eryu Guan wrote:
>> +
>> +# Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
>> +$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
>> +	_notrun "No GETNEXTQUOTA support"
> Introduce a new _require rule? And generic/244 could use it too. Perhaps
> we need to put '_require_test_program "test-nextquota"' in the new
> require rule too.

Good point.

And the other stuff is just leftovers from 344 - sorry about that.

-Eric

> Thanks,
> Eryu
> 
