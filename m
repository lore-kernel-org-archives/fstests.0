From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: xfsprogs: Add BUILD_CFLAGS for cross compilation
Date: Fri, 27 May 2016 09:34:50 -0700
Message-ID: <CAMHSBOUQ5eUL+Y+voDCwC9U7gmTsUZu2Oympn+c0=DxaU4egjA@mail.gmail.com>
References: <1437913255-7524-4-git-send-email-tytso@mit.edu>
	<1454361909-36538-1-git-send-email-gwendal@chromium.org>
	<20160202180828.GA13880@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0276501827349179257=="
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <20160202180828.GA13880@infradead.org>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, xfs@oss.sgi.com
List-Id: fstests@vger.kernel.org

--===============0276501827349179257==
Content-Type: multipart/alternative; boundary=047d7b5d5ffe85aa930533d57d46

--047d7b5d5ffe85aa930533d57d46
Content-Type: text/plain; charset=UTF-8

Looking at xfsprogs-4.5.0, that patch has not been applied. Did it not work?
It still applies cleanly on 4.5.

Gwendal.

On Tue, Feb 2, 2016 at 10:08 AM, Christoph Hellwig <hch@infradead.org>
wrote:

> On Mon, Feb 01, 2016 at 01:25:09PM -0800, Gwendal Grignou wrote:
> > When cross compiling, CFLAGS may contains option for the cros-compiler
> the
> > host compiler can not handle.
> > Add BUILD_CFLAGS variable that does not include $OPTIMIZER options.
>
> I would have expected this to be HOST_CFLAGS, but it seems the
> BUILD_ convention already exists in xfsprogs, so sticking to it
> looks fine to me.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

--047d7b5d5ffe85aa930533d57d46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looking at xfsprogs-4.5.0, that patch has not been applied=
. Did it not work?<div>It still applies cleanly on 4.5.<br><div><br></div><=
div>Gwendal.</div></div></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Tue, Feb 2, 2016 at 10:08 AM, Christoph Hellwig <span dir=
=3D"ltr">&lt;<a href=3D"mailto:hch@infradead.org" target=3D"_blank">hch@inf=
radead.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Mon, Feb 01, 2016 at 01:25:09PM -0800, Gwendal Grignou wrote:<b=
r>
&gt; When cross compiling, CFLAGS may contains option for the cros-compiler=
 the<br>
&gt; host compiler can not handle.<br>
&gt; Add BUILD_CFLAGS variable that does not include $OPTIMIZER options.<br=
>
<br>
</span>I would have expected this to be HOST_CFLAGS, but it seems the<br>
BUILD_ convention already exists in xfsprogs, so sticking to it<br>
looks fine to me.<br>
<br>
Reviewed-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de=
</a>&gt;<br>
</blockquote></div><br></div>

--047d7b5d5ffe85aa930533d57d46--


--===============0276501827349179257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs

--===============0276501827349179257==--
