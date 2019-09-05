Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIEAdz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 20:33:55 -0400
Message-ID: <d8a1d8e856be8eb50a78bd9f6b0ac9940001d66b.camel@kernel.org>
Subject: Re: [PATCH v2] generic: Add a test for basic F_SETLEASE
 functionality
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Sep 2019 20:33:52 -0400
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E898E7BD9@CRSMSX101.amr.corp.intel.com>
References: <20190827123537.18794-1-jlayton@kernel.org>
         <20190904124849.15816-1-jlayton@kernel.org>
         <2807E5FD2F6FDA4886F6618EAC48510E898E7BD9@CRSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Weiny, Ira" <ira.weiny@intel.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "bfields@fieldses.org" <bfields@fieldses.org>, "amir73il@gmail.com" <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, 2019-09-04 at 16:52 +0000, Weiny, Ira wrote:
> > Subject: [PATCH v2] generic: Add a test for basic F_SETLEASE functionality
> > 
> > Add a new test that verifies that F_SETLEASE works as expected. The parent
> > opens a file and sets a lease on it and then forks. The child then does a
> > (possibly) conflicting open. We then verify that we get signals as expected.
> 
> Jeff, does this mean you would rather go with this test vs the one I submitted?
> 
> https://www.spinics.net/lists/fstests/msg12449.html
> 
> Ira
> 

No, actually...I'm sorry, I didn't notice your posting until just now.

I think your test (with the proposed changes) covers more cases and will
probably be more extensible later. I'll give it a more thorough review
tomorrow, but I expect we can just drop this patch and just go with your
tests.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
