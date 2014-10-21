Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbaJUDQM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 20 Oct 2014 23:16:12 -0400
Date: Tue, 21 Oct 2014 11:15:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: Can't build RPM of xfstests
Message-ID: <20141021031543.GB13850@dhcp-13-216.nay.redhat.com>
References: <648473255763364B961A02AC3BE1060D03C7940C13@MX19A.corp.emc.com>
 <20141020014750.GL7169@dastard>
 <54448313.7040602@sandeen.net>
 <30CA1845-C213-49EA-8809-F1E7A98AE7F9@gmail.com>
 <54451427.9060306@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54451427.9060306@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Dave Chinner <david@fromorbit.com>, "Kaul, Yaniv" <Yaniv.Kaul@emc.com>, esandeen@redhat.com, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 20, 2014 at 08:54:47AM -0500, Eric Sandeen wrote:
> On 10/20/14 6:55 AM, Greg Freemyer wrote:
> 
> > Opensuse is building rpms of 1.1.1 so the build infrastructure isn't
> > too badly broken.  I don't know if they are following FHS, but I
> > doubt they use /opt.
> 
> The build works fine, it's the "Makepkgs" that I think is a bit odd,
> at least for RPM packaging.
> 
> Also, if we really want to encourage packaging, we should probably start
> sticking official version numbers on it.  "1.1.1" was tagged in Dec 2012,
> and there have been no "releases" since.
> 
> > The opensuse package/specfile can be found at:
> > https://build.opensuse.org/package/show/filesystems/xfstests
> > 
> > The rpms including the source rpm can be downloaded from: 
> > http://software.opensuse.org/download.html?project=filesystems&package=xfstests
> >
> >  Note the specfile applies a patch to change the install aspect of
> > the tarball immediately after untar'ing it.
> > 
> > I don't maintain that so I don't know why the patch is needed.
> 
> Ok, cool, I'll take a look at the specfile & patch.  I had also packaged
> it up for our internal QA use long ago, and had to make a few changes
> as well.

This is the spec file used internally by Red Hat, just for your reference

Thanks,
Eryu

Name:	    xfstests
Version:    20141014
Release:    1.git
Summary:    xfs qa tests

Group:	    	misc
License:	GPL
URL:            http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfstests.git
Source0:        $RPM_BUILD_ROOT/SOURCES/xfstests-dev.tar.bz2
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:	autoconf, libtool, e2fsprogs-devel, xfsprogs-devel
BuildRequires:	libacl-devel, libattr-devel, libaio-devel
Requires:       bash, perl, acl, attr, bind-utils
Requires:	bc, indent, quota, xfsprogs

%description
The xfsqa test available at http://git.kernel.org/?p=fs/xfs/xfstests-dev.git or http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfstests.git

%prep
%setup -q -n xfstests-dev

%build
autoheader
autoconf
%configure
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
# Dirty workaround, xfstets won't build if these two directories do not exist...
mkdir -p /var/lib/xfstests/{ltp,src}

make DIST_ROOT=$RPM_BUILD_ROOT install

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc README
/var/lib/xfstests


%changelog
......

> 
> -Eric
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
